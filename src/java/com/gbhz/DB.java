package com.gbhz;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DB {
	private static SqlSessionFactory sqlSF = connectDatabase();
	
	private static SqlSessionFactory connectDatabase() {
		String configFilePath = DB.class.getResource("/mybatis/dbConfig.xml").getFile();
		FileReader fileReader;
		try {
			fileReader = new FileReader(configFilePath);
			sqlSF = new SqlSessionFactoryBuilder().build(fileReader);
		} catch (FileNotFoundException e) {
			/* Log.error(e); */
		}
		return sqlSF;
	}
	
	/*
	 * public static List<Map<Object, Object>> select(String queryId) { SqlSession
	 * ss = sqlSF.openSession(); return ss.selectList(queryId); }
	 */
	
	public static List<Map<Object, Object>> select(String sql) {
		SqlSession ss = sqlSF.openSession();
		return ss.selectList("default.selectSql",sql);
	}
	
	public static int update(String sql) {
		SqlSession ss = sqlSF.openSession();
		int ret = ss.update("default.updateSql",sql);
		ss.commit();
		return ret;
	}
	
	public static Map<Object, Object> selectDetail(String sql) {
		List<Map<Object, Object>> ret = select(sql);
		return (ret.size()>0)? ret.get(0) : null;
	}
	
	
}
