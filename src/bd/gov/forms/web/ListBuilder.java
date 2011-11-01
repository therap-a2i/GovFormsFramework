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
package bd.gov.forms.web;

import bd.gov.forms.dao.ListDao;
import bd.gov.forms.domain.ListData;
import bd.gov.forms.utils.FormUtil;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;

import bd.gov.forms.utils.UserAccessChecker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author asif
 */
@Controller
@RequestMapping("/listBuilder")
public class ListBuilder {

    private static final Logger log = LoggerFactory.getLogger(ListBuilder.class);

    @Autowired
    private ListDao listDao;

    @RequestMapping(value = "/newList", method = RequestMethod.GET)
    public String newList(ModelMap model, HttpServletRequest request) {
        String access = UserAccessChecker.check(request);
        if (access != null) {
            return access;
        }

        ListData listData = new ListData();

        model.put("listDataCmd", listData);
        model.put("formAction", "saveList");

        return "listData";
    }

    @RequestMapping(value = "/saveList", method = RequestMethod.POST)
    public String saveForm(@ModelAttribute("listDataCmd") ListData listData,
                           BindingResult result, HttpServletRequest request, ModelMap model) {

        String access = UserAccessChecker.check(request);
        if (access != null) {
            return access;
        }

        if (FormUtil.isEmpty(listData.getName()) || FormUtil.isEmpty(listData.getValues())) {
            throw new RuntimeException("Required value not found.");
        }

        model.put("listDataCmd", listData);
        model.put("formAction", "saveList");

        log.debug("listData->save");

        listData.setSysId(Long.toString(System.nanoTime()) + new Long(new Random().nextLong()));
        listDao.saveListData(listData);

        model.put("message", "msg.form.submitted");
        model.put("msgType", "success");

        return "redirect:list.htm";
    }

    @RequestMapping(value = "/editList", method = RequestMethod.GET)
    public String editList(@RequestParam(value = "sysId", required = true) String sysId,
                           ModelMap model, HttpServletRequest request) {

        String access = UserAccessChecker.check(request);
        if (access != null) {
            return access;
        }

        ListData listData = null;

        if (sysId != null) {
            listData = listDao.getListData(sysId);
        }

        model.put("listDataCmd", listData);
        model.put("formAction", "updateList");

        return "listData";
    }

    @RequestMapping(value = "/updateList", method = RequestMethod.POST)
    public String updateForm(@ModelAttribute("listDataCmd") ListData listData,
                             BindingResult result, HttpServletRequest request, ModelMap model) {

        String access = UserAccessChecker.check(request);
        if (access != null) {
            return access;
        }

        if (FormUtil.isEmpty(listData.getName()) || FormUtil.isEmpty(listData.getValues())) {
            throw new RuntimeException("Required value not found.");
        }

        model.put("listDataCmd", listData);
        model.put("formAction", "updateList");

        log.debug("listData->update");

        listDao.updateListData(listData);

        model.put("message", "List Successfully Updated");
        model.put("msgType", "success");

        return "redirect:list.htm";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(ModelMap model, HttpServletRequest request) throws IOException {
        String access = UserAccessChecker.check(request);
        if (access != null) {
            return access;
        }

        List list = listDao.getListDataList();

        model.put("list", list);

        return "listDataList";
    }

}
