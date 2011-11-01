/*
 * Copyright (C) 2011 Therap (BD) Ltd.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package bd.gov.forms.dao;

import bd.gov.forms.domain.Field;
import bd.gov.forms.domain.Form;

import java.io.ByteArrayInputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.stereotype.Repository;

/**
 * @author asif
 */
@Repository("formDao")
@SuppressWarnings("unchecked")
public class FormDaoImpl implements FormDao {

    private static final Logger log = LoggerFactory.getLogger(FormDaoImpl.class);

    private static final int FORM_ENTRY_RESULTS_PER_PAGE = 5;

    @Autowired
    DefaultLobHandler lobHandler;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void saveForm(final Form form) {
        String sql = "INSERT INTO form";
        sql += " (form_id, title, subtitle, detail, status";

        if (formHasTemplate(form)) {
            sql += ", template_file, template_file_name";
        }

        sql += ")";
        sql += " VALUES (?, ?, ?, ?, ?";

        if (formHasTemplate(form)) {
            sql += " , ?, ?";
        }

        sql += ")";

        log.debug("SQL INSERT query: {}" + sql);

        jdbcTemplate.execute(sql,
                new AbstractLobCreatingPreparedStatementCallback(lobHandler) {

                    @Override
                    protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
                        int i = 1;

                        ps.setString(i++, form.getFormId());
                        ps.setString(i++, form.getTitle());
                        ps.setString(i++, form.getSubTitle());
                        ps.setString(i++, form.getDetail());
                        ps.setInt(i++, form.getStatus());

                        if (formHasTemplate(form)) {
                            lobCreator.setBlobAsBinaryStream(ps, i++, new ByteArrayInputStream(form.getPdfTemplate()),
                                    form.getPdfTemplate().length);
                            ps.setString(i, form.getTemplateFileName());
                        }
                    }
                }
        );
    }

    private boolean formHasTemplate(Form form) {
        return form.getPdfTemplate() != null && form.getPdfTemplate().length > 0;
    }

    @Override
    public Form getForm(String formId) {
        return (Form) jdbcTemplate.queryForObject(
                "SELECT * FROM form WHERE form_id = ?",
                new Object[]{formId},
                new RowMapper() {

                    public Object mapRow(ResultSet resultSet, int rowNum) throws SQLException {
                        Form form = new Form();

                        form.setId(resultSet.getInt("id"));
                        form.setFormId(resultSet.getString("form_id"));
                        form.setTitle(resultSet.getString("title"));
                        form.setSubTitle(resultSet.getString("subtitle"));
                        form.setDetail(resultSet.getString("detail"));
                        form.setTableName(resultSet.getString("table_name"));
                        form.setStatus(resultSet.getInt("status"));
                        form.setTemplateFileName(resultSet.getString("template_file_name"));

                        return form;
                    }
                }
        );
    }

    public void updateForm(final Form form) {
        String sql = "UPDATE form";
        sql += " set title = ?, subtitle = ?, detail = ?, status = ?";

        if (formHasTemplate(form)) {
            sql += ", template_file = ?, template_file_name = ?";
        }

        sql += " WHERE form_id = ?";

        log.debug("SQL UPDATE query: {}", sql);

        jdbcTemplate.execute(sql,
                new AbstractLobCreatingPreparedStatementCallback(lobHandler) {

                    @Override
                    protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
                        int i = 1;

                        ps.setString(i++, form.getTitle());
                        ps.setString(i++, form.getSubTitle());
                        ps.setString(i++, form.getDetail());
                        ps.setInt(i++, form.getStatus());

                        if (formHasTemplate(form)) {
                            lobCreator.setBlobAsBinaryStream(ps, i++, new ByteArrayInputStream(form.getPdfTemplate()),
                                    form.getPdfTemplate().length);
                            ps.setString(i++, form.getTemplateFileName());
                        }

                        ps.setString(i, form.getFormId());
                    }
                }
        );
    }

    public byte[] getTemplateContent(String formId) {
        Form form = (Form) jdbcTemplate.queryForObject(
                "SELECT template_file FROM form WHERE form_id = ?",
                new Object[]{formId},
                new RowMapper() {

                    public Object mapRow(ResultSet resultSet, int rowNum) throws SQLException {
                        Form form = new Form();

                        form.setPdfTemplate(resultSet.getBytes("template_file"));

                        return form;
                    }
                }
        );

        return form.getPdfTemplate();
    }
    
    public Form getFormWithFields(String formId) {
        Form form = getForm(formId);

        log.debug("formId: {}", form != null ? form.getId() : "form is null");

        if (form != null) {
            List fields = jdbcTemplate.query(
                    "SELECT * FROM field WHERE form_id = ? order by field_order",
                    new Object[]{form.getId()},
                    new RowMapper() {

                        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                            Field fld = new Field();

                            fld.setId(rs.getInt("id"));
                            fld.setFormId(rs.getInt("form_id"));
                            fld.setFieldId(rs.getString("field_id"));
                            fld.setType(rs.getString("type"));
                            fld.setColName(rs.getString("col_name"));
                            fld.setLabel(rs.getString("label"));
                            fld.setHelpText(rs.getString("help_text"));
                            fld.setOptions(rs.getString("options"));
                            fld.setListDataId(rs.getInt("list_data_id"));
                            fld.setDefaultValue(rs.getString("def_value"));
                            fld.setFieldOrder(rs.getInt("field_order"));
                            fld.setRequired(rs.getInt("required"));
                            fld.setInputType(rs.getString("input_type"));

                            return fld;
                        }
                    }
            );

            form.setFields(fields);
        }

        return form;
    }

    public Field getField(String fieldId) {
        return (Field) jdbcTemplate.queryForObject(
                "SELECT * FROM field WHERE field_id = ? ",
                new Object[]{fieldId},
                new RowMapper() {

                    public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Field fld = new Field();

                        fld.setId(rs.getInt("id"));
                        fld.setFormId(rs.getInt("form_id"));
                        fld.setFieldId(rs.getString("field_id"));
                        fld.setType(rs.getString("type"));
                        fld.setColName(rs.getString("col_name"));
                        fld.setLabel(rs.getString("label"));
                        fld.setHelpText(rs.getString("help_text"));
                        fld.setOptions(rs.getString("options"));
                        fld.setListDataId(rs.getInt("list_data_id"));
                        fld.setDefaultValue(rs.getString("def_value"));
                        fld.setFieldOrder(rs.getInt("field_order"));
                        fld.setRequired(rs.getInt("required"));
                        fld.setInputType(rs.getString("input_type"));

                        return fld;
                    }
                }
        );
    }

    public void saveField(final Field field) {
        String sql = "INSERT INTO field";
        sql += " (field_id, form_id, type, input_type, label, required, help_text, options, list_data_id, def_value, "
                + "field_order";
        sql += ")";
        sql += " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?";
        sql += ")";

        log.debug("SQL INSERT query: {}", sql);

        jdbcTemplate.execute(sql,
                new AbstractLobCreatingPreparedStatementCallback(lobHandler) {

                    @Override
                    protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
                        int i = 1;

                        ps.setString(i++, field.getFieldId());
                        ps.setInt(i++, field.getFormId());
                        ps.setString(i++, field.getType());
                        ps.setString(i++, field.getInputType());
                        ps.setString(i++, field.getLabel());
                        ps.setInt(i++, field.getRequired());
                        ps.setString(i++, field.getHelpText());
                        ps.setString(i++, field.getOptions());
                        ps.setInt(i++, field.getListDataId());
                        ps.setString(i++, field.getDefaultValue());
                        ps.setInt(i, field.getFieldOrder());
                    }
                }
        );
    }

    public void updateField(final Field field) {
        String sql = "UPDATE field";
        sql += " set type = ?, input_type = ?, label = ?, required = ?, help_text = ?, options = ?, list_data_id = ?, "
                + "def_value = ?, field_order = ?";
        sql += " WHERE field_id = ? and form_id = ?";

        log.debug("SQL UPDATE query: {}", sql);
        log.debug("formId: {}, fieldId: {}", field.getFormId(), field.getFieldId());

        jdbcTemplate.execute(sql,
                new AbstractLobCreatingPreparedStatementCallback(lobHandler) {

                    @Override
                    protected void setValues(PreparedStatement ps, LobCreator lobCreator)
                            throws SQLException {
                        int i = 1;

                        ps.setString(i++, field.getType());//*
                        ps.setString(i++, field.getInputType());
                        ps.setString(i++, field.getLabel());
                        ps.setInt(i++, field.getRequired());
                        ps.setString(i++, field.getHelpText());
                        ps.setString(i++, field.getOptions());
                        ps.setInt(i++, field.getListDataId());
                        ps.setString(i++, field.getDefaultValue());
                        ps.setInt(i++, field.getFieldOrder());//*

                        ps.setString(i++, field.getFieldId());
                        ps.setInt(i, field.getFormId());
                    }
                }
        );
    }

    public void moveField(int formId, String fieldId, int fieldOrder, int order) {
        jdbcTemplate.update("UPDATE field SET field_order = ? WHERE form_id = ? and field_order = ?",
                fieldOrder, formId, order);
        jdbcTemplate.update("UPDATE field SET field_order = ? WHERE form_id = ? and field_id = ?",
                order, formId, fieldId);
    }

    public void updateOrder(int formId, int fieldOrder, String operator) {
        jdbcTemplate.update("UPDATE field SET field_order = field_order" + operator
                + "1 WHERE form_id = ? and field_order >= ?", formId, fieldOrder);
    }

    public void deleteField(String fieldId, int formId) {
        jdbcTemplate.update("DELETE FROM field WHERE field_id = ? and form_id = ?", fieldId, formId);
    }

    public void deleteForm(String formId) {
        jdbcTemplate.update("DELETE FROM form WHERE form_id = ? and status = 1", formId);
    }

    public void createTable(Form frm) {
        String cols = "";

        for (Field f : frm.getFields()) {
            if (!"note".equals(f.getType()) && !"section".equals(f.getType())) {
                String type = "LONGTEXT";

                if ("file".equals(f.getType())) {
                    type = "LONGBLOB";
                }

                cols += f.getColName() + " " + type + ", ";

                if ("file".equals(f.getType())) {
                    cols += f.getColName() + "_fname" + " LONGTEXT, ";
                }
            }
        }

        cols = cols.substring(0, cols.length() - 2);

        String sql = "CREATE TABLE " + frm.getTableName();
        sql += " (" + "id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, entry_id TEXT NOT NULL, entry_date DATE NOT NULL, "
                + "entry_time TIME NOT NULL, entry_status TEXT NOT NULL, " + cols + ") DEFAULT CHARSET=utf8 ";

        log.debug("CREATE TABLE sql: {}", sql);

        jdbcTemplate.update(sql);
    }

    public void saveEntry(final Form form) {
        String cols = "entry_date, entry_time, entry_id, entry_status, ";
        String val = "CURDATE(), CURTIME(), ?, ?, ";

        for (Field field : form.getFields()) {
            if (fieldTypeIsNotFileOrNoteOrSection(field.getType())) {
                cols += field.getColName() + ", ";
                val += "? , ";
            }

            if ("file".equals(field.getType())) {
                if (notEmpty(field.getByteVal())) {
                    cols += field.getColName() + ", " + field.getColName() + "_fname, ";
                    val += "? , ?, ";
                }
            }
        }

        cols = cols.substring(0, cols.length() - 2);
        val = val.substring(0, val.length() - 2);

        String sql = "INSERT INTO " + form.getTableName();
        sql += " (" + cols + ")";
        sql += " VALUES (" + val + ")";

        log.debug("SQL INSERT query: {}", sql);

        jdbcTemplate.execute(sql,
                new AbstractLobCreatingPreparedStatementCallback(lobHandler) {

                    protected void setValues(PreparedStatement ps, LobCreator lobCreator) throws SQLException {
                        int i = 1;

                        ps.setString(i++, form.getEntryId());
                        ps.setString(i++, form.getEntryStatus());

                        for (Field field : form.getFields()) {
                            if (fieldTypeIsNotFileOrNoteOrSection(field.getType())) {
                                ps.setString(i++, field.getStrVal());
                            }

                            if ("file".equals(field.getType())) {
                                if (notEmpty(field.getByteVal())) {
                                    lobCreator.setBlobAsBinaryStream(ps, i++, new ByteArrayInputStream(field.getByteVal()), field.getByteVal().length);
                                    ps.setString(i++, field.getStrVal());
                                    log.debug("File Name: {}", field.getStrVal());
                                }
                            }
                        }
                    }
                }
        );
    }

    private boolean notEmpty(byte[] content) {
        return content != null && content.length > 0;
    }

    private boolean fieldTypeIsNotFileOrNoteOrSection(String fieldType) {
        return !"file".equals(fieldType) && !"note".equals(fieldType) && !"section".equals(fieldType);
    }

    public List getFormList(int page) {
        String sql = "select * from form";

        return jdbcTemplate.query(sql,
                new RowMapper() {

                    public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Form form = new Form();

                        populateFormFromResultSet(rs, form);

                        return form;
                    }
                });
    }

    private void populateFormFromResultSet(ResultSet rs, Form form) throws SQLException {
        form.setFormId(rs.getString("form_id"));
        form.setStatus(rs.getInt("status"));
        form.setTitle(rs.getString("title"));
        form.setDetail(rs.getString("detail"));
    }

    public List getPublicForms() {
        String sql = "select * from form where status=2";

        return this.jdbcTemplate.query(sql,
                new RowMapper() {

                    public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Form form = new Form();

                        populateFormFromResultSet(rs, form);

                        return form;
                    }
                });
    }

    public void updateStatus(String formId, int status) {
        jdbcTemplate.update("UPDATE form set status = ? WHERE form_id = ?", status, formId);
    }

    public void initDbIdentifiers(int id) {
        jdbcTemplate.update("UPDATE form set table_name = concat('table', id) WHERE id = ?", id);
        jdbcTemplate.update("UPDATE field set col_name = concat('col', id) WHERE form_id = ?", id);
    }

    public List getEntryList(final Form form, Integer page, String colName, String colVal,
                             String sortCol, String sortOrder, boolean limit) {
        String where;
        if (colName != null && !"".equals(colName) && colVal != null && !"".equals(colVal)) {
            where = " WHERE " + colName + " LIKE ? ";
        } else {
            where = " WHERE 1 = ? ";
            colVal = "1";
        }

        String order = " ORDER BY ";
        if (sortCol != null && !"".equals(sortCol)) {
            order += sortCol + " ";
        } else {
            order += " entry_date ";
        }
        order += sortOrder + " ";

        int totalRows = jdbcTemplate.queryForInt("SELECT COUNT(*) FROM " + form.getTableName() + where, colVal);

        int resultsPerPage = totalRows;
        if (limit) {
            resultsPerPage = FORM_ENTRY_RESULTS_PER_PAGE;
        }

        int totalPages = 0;
        try {
            totalPages = totalRows / resultsPerPage;
            if (totalRows % resultsPerPage > 0) {
                totalPages++;
            }
        } catch (ArithmeticException ignore) {
        }

        if (page > totalPages || page < 1) {
            page = 1;
        }

        int start = (page - 1) * resultsPerPage;

        form.setTotalPages(totalPages);

        String sql = "SELECT * FROM " + form.getTableName() + where + order + " LIMIT ?, ?";
        log.debug("getEntryList SQL query: {}", sql);

        return this.jdbcTemplate.query(sql,
                new Object[]{colVal, start, resultsPerPage},
                new RowMapper() {

                    public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                        Map map = new HashMap();

                        for (Field field : form.getFields()) {
                            map.put("entry_id", rs.getString("entry_id"));
                            map.put("entry_date", rs.getString("entry_date"));
                            map.put("entry_time", rs.getString("entry_time"));
                            map.put("entry_status", rs.getString("entry_status"));

                            if (fieldTypeIsNotFileOrNoteOrSection(field.getType())) {
                                map.put(field.getColName(), rs.getString(field.getColName()));
                            }
                        }

                        return map;
                    }
                });
    }

    public Form getEntry(final Form form) {
        String sql = "SELECT * FROM " + form.getTableName() + " WHERE entry_id = ?";

        log.debug("entryId: {}", form.getEntryId());
        log.debug("sql: {}", sql);

        return (Form) this.jdbcTemplate.queryForObject(sql,
                new Object[]{form.getEntryId()},
                new RowMapper() {

                    public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                        for (Field field : form.getFields()) {
                            if (fieldTypeIsNotFileOrNoteOrSection(field.getType())) {
                                field.setStrVal(rs.getString(field.getColName()));
                            }
                        }

                        return form;
                    }
                });
    }

    public void updateEntryStatus(Form form, String entryId, String status) {
        jdbcTemplate.update("UPDATE " + form.getTableName() + " set entry_status = ? WHERE entry_id = ?",
                status, entryId);
    }

    public void removeTemplate(String formId) {
        jdbcTemplate.update("UPDATE form set  template_file = null, template_file_name = null WHERE form_id = ?",
                formId);
    }
}
