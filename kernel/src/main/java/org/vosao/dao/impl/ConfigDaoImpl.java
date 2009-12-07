/**
 * Vosao CMS. Simple CMS for Google App Engine.
 * Copyright (C) 2009 Vosao development team
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * email: vosao.dev@gmail.com
 */

package org.vosao.dao.impl;

import java.util.List;

import org.vosao.dao.ConfigDao;
import org.vosao.entity.ConfigEntity;

public class ConfigDaoImpl extends BaseDaoImpl<Long, ConfigEntity> 
		implements ConfigDao {

	public ConfigDaoImpl() {
		super(ConfigEntity.class);
	}

	@Override
	public ConfigEntity getConfig() {
		List<ConfigEntity> list = select();
		if (list.size() > 0) {
			return list.get(0);
		}
		logger.error("Config for site was not found!");
		return new ConfigEntity();
	}

}
