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

import bd.gov.forms.domain.User;

import java.util.List;

/**
 * @author asif
 */
public interface UserDao {

    public void saveUser(final User user);

    public User getUser(String sysId);

    public void updateUser(final User user);

    public List getUserList();

    public User getUser(String userName, String password);

    public User getUserWithEmail(String userName, String email);

    public int changePassword(String userName, String password);

    public int getCountWithUserName(String userName);

}
