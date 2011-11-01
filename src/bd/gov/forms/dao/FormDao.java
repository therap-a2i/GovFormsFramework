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

import java.util.List;

/**
 * @author asif
 */
public interface FormDao {

    public void saveForm(final Form frm);

    public Form getForm(String formId);

    public void updateForm(final Form frm);

    public void deleteForm(String formId);

    public byte[] getTemplateContent(String formId);

    public Form getFormWithFields(String formId);

    public Field getField(String fieldId);

    public void saveField(final Field fld);

    public void updateField(final Field fld);

    public void deleteField(String fieldId, int formId);

    public void updateOrder(int formId, int fieldOrder, String operator);

    public void moveField(int formId, String fieldId, int fieldOrder, int order);

    public List getFormList(int page);

    public void updateStatus(String formId, int i);

    public void createTable(Form frm);

    public void saveEntry(final Form frm2);

    public void initDbIdentifiers(int id);

    public List getEntryList(final Form frm, Integer page, String colName, String colVal, String sortCol,
                             String sortDir, boolean limit);

    public Form getEntry(final Form frm);

    public void updateEntryStatus(Form frm, String entryId, String string);

    public void removeTemplate(String formId);

    public List getPublicForms();

}
