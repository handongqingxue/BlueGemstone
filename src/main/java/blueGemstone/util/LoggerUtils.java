package blueGemstone.util;

import org.apache.log4j.Logger;
/**
 * 
 * �?发公司：SOJSON在线工具 <p>
 * 版权�?有：© www.sojson.com<p>
 * 博客地址：http://www.sojson.com/blog/  <p>
 * <p>
 * 
 * Log输出封装
 * 
 * <p>
 * 
 * 区分�?责任人�??日期�?�?�?�?说明<br/>
 * 创建�?周柏成�??2016�?6�?2�? �?<br/>
 *
 * @author zhou-baicheng
 * @email  so@sojson.com
 * @version 1.0,2016�?6�?2�? <br/>
 * 
 */
public class LoggerUtils {
	/**
	 * 是否�?启Debug
	 */
	public static boolean isDebug =  Logger.getLogger(LoggerUtils.class).isDebugEnabled();
	
	/**
	 * Debug 输出
	 * @param clazz  	目标.Class
	 * @param message	输出信息
	 */
	public static void debug(Class<? extends Object> clazz ,String message){
		if(!isDebug)return ;
		Logger logger = Logger.getLogger(clazz);
		logger.debug(message);
	}
	/**
	 * Debug 输出
	 * @param clazz  	目标.Class
	 * @param fmtString 输出信息key
	 * @param value		输出信息value
	 */
	public static void fmtDebug(Class<? extends Object> clazz,String fmtString,Object...value){
		if(!isDebug)return ;
		if(StringUtils.isBlank(fmtString)){
			return ;
		}
		if(null != value && value.length != 0){
			fmtString = String.format(fmtString, value);
		}
		debug(clazz, fmtString);
	}
	/**
	 * Error 输出
	 * @param clazz  	目标.Class
	 * @param message	输出信息
	 * @param e			异常�?
	 */
	public static void error(Class<? extends Object> clazz ,String message,Exception e){
		Logger logger = Logger.getLogger(clazz);
		if(null == e){
			logger.error(message);
			return ;
		}
		logger.error(message, e);
	}
	/**
	 * Error 输出
	 * @param clazz  	目标.Class
	 * @param message	输出信息
	 */
	public static void error(Class<? extends Object> clazz ,String message){
		error(clazz, message, null);
	}
	/**
	 * 异常填充值输�?
	 * @param clazz 	目标.Class
	 * @param fmtString	输出信息key
	 * @param e			异常�?
	 * @param value		输出信息value
	 */
	public static void fmtError(Class<? extends Object> clazz,Exception e,String fmtString,Object...value){
		if(StringUtils.isBlank(fmtString)){
			return ;
		}
		if(null != value && value.length != 0){
			fmtString = String.format(fmtString, value);
		}
		error(clazz, fmtString, e);
	}
	/**
	 * 异常填充值输�?
	 * @param clazz		目标.Class
	 * @param fmtString 输出信息key
	 * @param value		输出信息value
	 */
	public static void fmtError(Class<? extends Object> clazz,
			String fmtString, Object...value) {
		if(StringUtils.isBlank(fmtString)){
			return ;
		}
		if(null != value && value.length != 0){
			fmtString = String.format(fmtString, value);
		}
		error(clazz, fmtString);
	}
}
