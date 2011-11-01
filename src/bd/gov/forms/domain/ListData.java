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
package bd.gov.forms.domain;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

/**
 * @author asif
 */
public class ListData {

    private int id;
    private String sysId;
    private String name;
    private String detail;
    private String values;

    public List getList(String type) throws Exception {
        List<String> list = new ArrayList<String>();

        if ("select".equals(type)) {
            list.add("");
        }
        
        if (values != null) {
            list.addAll(getNewlineDelimitedValuesAsList(values));
        }

        return list;
    }

    private List<String> getNewlineDelimitedValuesAsList(String values) throws IOException {
        List<String> list = new ArrayList<String>();

        BufferedReader reader = new BufferedReader(new StringReader(values));

        String str;
        while ((str = reader.readLine()) != null) {
            str = str.trim();
            if (str.length() > 0) {
                list.add(str);
            }
        }
        
        return list;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String details) {
        this.detail = details;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValues() {
        return values;
    }

    public void setValues(String values) {
        this.values = values;
    }

    public String getSysId() {
        return sysId;
    }

    public void setSysId(String sysId) {
        this.sysId = sysId;
    }

}
