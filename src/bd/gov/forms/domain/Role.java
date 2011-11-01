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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author asif
 */
public class Role {

    private static final Logger log = LoggerFactory.getLogger(Role.class);

    public static final int ROLE_USER = 0;
    public static final int ROLE_ADMIN = 1;

    public static String checkRole(int role, User user) {
        if (user == null) {
            log.debug("User is null");
            return "redirect:/userMgt/login.htm?message=msg.login.expired&msgType=failed";
        } else if (user.getAdmin() < role) {
            log.debug("Access denied for user: {}", user.getName());
            return "redirect:/formBuilder/done.htm?doneMessage=msg.access.denied&doneMsgType=failed";
        }

        log.debug("User role: {}", user.getAdmin());

        return null;
    }

}
