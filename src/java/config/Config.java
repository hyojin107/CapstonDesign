package config;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStream;
import java.util.Enumeration;
import javax.servlet.ServletContext;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class Config {
	private static String root="";
	private static String prefix="";
	private static String defaultFilePath="";
	private static String defaultTempPath="";
	public static String sessionId="defaultLoginSession";
	public static SqlSessionFactory sqlSf = null;
	
	public static String getRoot() { return root; }
	protected static void setRoot(String root) { Config.root = root; }

	public static String getPrefix() { return prefix; }
	protected static void setPrefix(String prefix) { Config.prefix = prefix; }

	public static String getDefaultFilePath() { return defaultFilePath; }
	protected static void setDefaultFilePath(String defaultFilePath) { Config.defaultFilePath = defaultFilePath; }

	public static String getDefaultTempPath() { return defaultTempPath; }
	protected static void setDefaultTempPath(String defaultTempPath) { Config.defaultTempPath = defaultTempPath; }

	public static void setConfigFile(String filePath) throws Exception {
		File configFile = new File(filePath);
		if (!configFile.exists()) throw new Exception(String.format("Nto exists config file. [%s]", filePath));
	}
	public static void set(ServletContext servletContext) throws Exception {
		Enumeration<String> params = servletContext.getInitParameterNames();
		while(params.hasMoreElements()) {
			String id = params.nextElement();
			if ("root".equalsIgnoreCase(id)) setRoot(servletContext.getInitParameter(id));
			if ("prefix".equalsIgnoreCase(id)) setPrefix(servletContext.getInitParameter(id));
			if ("defaultFilePath".equalsIgnoreCase(id)) setDefaultFilePath(servletContext.getInitParameter(id));
			if ("defaultTempPath".equalsIgnoreCase(id)) setDefaultTempPath(servletContext.getInitParameter(id));
			if ("configFile".equalsIgnoreCase(id)) setConfigFile(servletContext.getInitParameter(id));
		}
	}
}
