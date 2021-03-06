package blueGemstone.util;

public class Constant {

	/**
	 * 变量1：料层差压
	 */
	public static final String LIAO_CENG_YA_CHA="料层差压";
	/**
	 * 变量2：炉膛差压
	 */
	public static final String LU_TANG_YA_CHA="炉膛差压";
	/**
	 * 变量3：饱和蒸汽压力
	 */
	public static final String BAO_HE_ZHENG_QI_YA_LI="饱和蒸汽压力";
	/**
	 * 变量4：过热蒸汽压力
	 */
	public static final String GUO_RE_ZHENG_QI_YA_LI="过热蒸汽压力";
	/**
	 * 变量5：风室压力
	 */
	public static final String FENG_SHI_YA_LI="风室压力";
	/**
	 * 变量6：三次风室压力1
	 */
	public static final String SAN_CI_FENG_SHI_YA_LI1="三次风室压力1";
	/**
	 * 变量7：三次风室压力2
	 */
	public static final String SAN_CI_FENG_SHI_YA_LI2="三次风室压力2";
	/**
	 * 变量8：床体温度1
	 */
	public static final String CHUANG_TI_WEN_DU1="床体温度1";
	/**
	 * 变量9：床体温度2
	 */
	public static final String CHUANG_TI_WEN_DU2="床体温度2";
	/**
	 * 变量10：床体温度3
	 */
	public static final String CHUANG_TI_WEN_DU3="床体温度3";
	/**
	 * 变量11：床体温度4
	 */
	public static final String CHUANG_TI_WEN_DU4="床体温度4";
	/**
	 * 变量12：过热蒸汽温度
	 */
	public static final String GUO_RE_ZHENG_QI_WEN_DU="过热蒸汽温度";
	/**
	 * 变量13：旋风分离器温度1
	 */
	public static final String XUAN_FENG_FEN_LI_QI_WEN_DU1="旋风分离器温度1";
	/**
	 * 变量14：旋风分离器温度2
	 */
	public static final String XUAN_FENG_FEN_LI_QI_WEN_DU2="旋风分离器温度2";
	/**
	 * 变量15：高温过热器前烟气（原来是：锅炉出口温度）
	 */
	public static final String GAO_WEN_GUO_RE_QI_QIAN_YAN_QI="高温过热器前烟气";
	/**
	 * 变量16：除氧器温度
	 */
	public static final String CHU_YANG_QI_WEN_DU="除氧器温度";
	/**
	 * 变量17：蒸汽流量计
	 */
	public static final String ZHENG_QI_LIU_LIANG_JI="蒸汽流量计";
	/**
	 * 变量18：水泵上水流量
	 */
	public static final String SHUI_BENG_SHANG_SHUI_LIU_LIANG="水泵上水流量";
	/**
	 * 变量19：含氧量表
	 */
	public static final String HAN_YANG_LIANG_BIAO="含氧量表";
	/**
	 * 变量20：锅筒液位（原来是：除氧器液位）
	 */
	public static final String GUO_TONG_YE_WEI="锅筒液位";
	/**
	 * 变量21：上水泵频率1
	 */
	public static final String SHANG_SHUI_BENG_PIN_LV1="上水泵频率1";
	/**
	 * 变量22：上水泵频率2
	 */
	public static final String SHANG_SHUI_BENG_PIN_LV2="上水泵频率2";
	/**
	 * 变量23：鼓风机频率
	 */
	public static final String GU_FENG_JI_PIN_LV="鼓风机频率";
	/**
	 * 变量24：引风机频率
	 */
	public static final String YIN_FENG_JI_PIN_LV="引风机频率";
	/**
	 * 变量25：二次风频率
	 */
	public static final String ER_CI_FENG_PIN_LV="二次风频率";
	/**
	 * 变量26：三次风频率1
	 */
	public static final String SAN_CI_FENG_PIN_LV1="三次风频率1";
	/**
	 * 变量27：三次风频率2
	 */
	public static final String SAN_CI_FENG_PIN_LV2="三次风频率2";
	/**
	 * 变量28：除氧器频率1
	 */
	public static final String CHU_YANG_QI_PIN_LV1="除氧器频率1";
	/**
	 * 变量29：除氧器频率2
	 */
	public static final String CHU_YANG_QI_PIN_LV2="除氧器频率2";
	/**
	 * 变量30：给煤频率1
	 */
	public static final String GEI_MEI_PIN_LV1="给煤频率1";
	/**
	 * 变量31：给煤频率2
	 */
	public static final String GEI_MEI_PIN_LV2="给煤频率2";
	/**
	 * 变量32：给煤频率3
	 */
	public static final String GEI_MEI_PIN_LV3="给煤频率3";
	
	/**
	 * 存放待插入的变量数组
	 */
	public static final String[] INSERT_ARR=new String[] {
			HAN_YANG_LIANG_BIAO,
			SHUI_BENG_SHANG_SHUI_LIU_LIANG,
			ZHENG_QI_LIU_LIANG_JI,
			CHU_YANG_QI_PIN_LV1,
			CHU_YANG_QI_PIN_LV2,
			ER_CI_FENG_PIN_LV,
			GEI_MEI_PIN_LV1,
			GEI_MEI_PIN_LV2,
			GEI_MEI_PIN_LV3,
			GU_FENG_JI_PIN_LV,
			SAN_CI_FENG_PIN_LV1,
			SAN_CI_FENG_PIN_LV2,
			SHANG_SHUI_BENG_PIN_LV1,
			SHANG_SHUI_BENG_PIN_LV2,
			YIN_FENG_JI_PIN_LV,
			CHUANG_TI_WEN_DU1,
			CHUANG_TI_WEN_DU2,
			CHUANG_TI_WEN_DU3,
			CHUANG_TI_WEN_DU4,
			CHU_YANG_QI_WEN_DU,
			GAO_WEN_GUO_RE_QI_QIAN_YAN_QI,
			GUO_RE_ZHENG_QI_WEN_DU,
			XUAN_FENG_FEN_LI_QI_WEN_DU1,
			XUAN_FENG_FEN_LI_QI_WEN_DU2,
			BAO_HE_ZHENG_QI_YA_LI,
			FENG_SHI_YA_LI,
			GUO_RE_ZHENG_QI_YA_LI,
			LIAO_CENG_YA_CHA,
			LU_TANG_YA_CHA,
			SAN_CI_FENG_SHI_YA_LI1,
			SAN_CI_FENG_SHI_YA_LI2,
			GUO_TONG_YE_WEI
		};
	
	/**
	 * 存放频率类型常量数组
	 */
	public static final String[] PIN_LV_TYPE=new String[] {
			SHANG_SHUI_BENG_PIN_LV1,
			SHANG_SHUI_BENG_PIN_LV2,
			GU_FENG_JI_PIN_LV,
			YIN_FENG_JI_PIN_LV,
			ER_CI_FENG_PIN_LV,
			SAN_CI_FENG_PIN_LV1,
			SAN_CI_FENG_PIN_LV2,
			CHU_YANG_QI_PIN_LV1,
			CHU_YANG_QI_PIN_LV2,
			GEI_MEI_PIN_LV1,
			GEI_MEI_PIN_LV2,
			GEI_MEI_PIN_LV3
		};

	/**
	 * 存放压力类型常量数组
	 */
	public static final String[] YA_LI_TYPE=new String[] {
			LIAO_CENG_YA_CHA,
			LU_TANG_YA_CHA,
			BAO_HE_ZHENG_QI_YA_LI,
			GUO_RE_ZHENG_QI_YA_LI,
			FENG_SHI_YA_LI,
			SAN_CI_FENG_SHI_YA_LI1,
			SAN_CI_FENG_SHI_YA_LI2
		};

	/**
	 * 存放温度类型常量数组
	 */
	public static final String[] WEN_DU_TYPE=new String[] {
			CHUANG_TI_WEN_DU1,
			CHUANG_TI_WEN_DU2,
			CHUANG_TI_WEN_DU3,
			CHUANG_TI_WEN_DU4,
			GUO_RE_ZHENG_QI_WEN_DU,
			CHU_YANG_QI_WEN_DU,
			XUAN_FENG_FEN_LI_QI_WEN_DU1,
			XUAN_FENG_FEN_LI_QI_WEN_DU2,
			GAO_WEN_GUO_RE_QI_QIAN_YAN_QI
	};

	/**
	 * 存放流量类型常量数组
	 */
	public static final String[] LIU_LIANG_TYPE=new String[] {
			ZHENG_QI_LIU_LIANG_JI,
			SHUI_BENG_SHANG_SHUI_LIU_LIANG
	};

	/**
	 * 存放液位类型常量数组
	 */
	public static final String[] YE_WEI_TYPE=new String[] {
			GUO_TONG_YE_WEI
	};

	/**
	 * 存放含氧量类型常量数组
	 */
	public static final String[] HAN_YANG_LIANG_TYPE=new String[] {
			HAN_YANG_LIANG_BIAO
	};
	
	/**
	 * 存放常量类型数组
	 */
	public static final String[][] VAR_TYPE=new String[][] {
			PIN_LV_TYPE,
			YA_LI_TYPE,
			WEN_DU_TYPE,
			LIU_LIANG_TYPE,
			YE_WEI_TYPE,
			HAN_YANG_LIANG_TYPE
	};
	
	public static final String[] VAR_TYPE_NAME=new String[] {"频率类","压力类","温度类","流量类","液位类","含氧量类"};
	
	public static final String[] PIN_LV_TYPE_NAME=new String[] {PIN_LV_TYPE[0],PIN_LV_TYPE[1],PIN_LV_TYPE[2],PIN_LV_TYPE[3],PIN_LV_TYPE[4],PIN_LV_TYPE[5],PIN_LV_TYPE[6],PIN_LV_TYPE[7],PIN_LV_TYPE[8],PIN_LV_TYPE[9],PIN_LV_TYPE[10],PIN_LV_TYPE[11]};
	
	public static final String[] YA_LI_TYPE_NAME=new String[] {YA_LI_TYPE[0],YA_LI_TYPE[1],YA_LI_TYPE[2],YA_LI_TYPE[3],YA_LI_TYPE[4],YA_LI_TYPE[5],YA_LI_TYPE[6]};
	
	public static final String[] WEN_DU_TYPE_NAME=new String[] {WEN_DU_TYPE[0],WEN_DU_TYPE[1],WEN_DU_TYPE[2],WEN_DU_TYPE[3],WEN_DU_TYPE[4],WEN_DU_TYPE[5],WEN_DU_TYPE[6],WEN_DU_TYPE[7],WEN_DU_TYPE[8]};
	
	public static final String[] LIU_LIANG_TYPE_NAME=new String[] {LIU_LIANG_TYPE[0],LIU_LIANG_TYPE[1]};
	
	public static final String[] YE_WEI_TYPE_NAME=new String[] {YE_WEI_TYPE[0]};
	
	public static final String[] HAN_YANG_LIANG_TYPE_NAME=new String[] {HAN_YANG_LIANG_TYPE[0]};
	
	public static final String[][] VAR_CHILD_TYPE_NAME=new String[][] {PIN_LV_TYPE_NAME,YA_LI_TYPE_NAME,WEN_DU_TYPE_NAME,LIU_LIANG_TYPE_NAME,YE_WEI_TYPE_NAME,HAN_YANG_LIANG_TYPE_NAME};
	
	/**
	 * PC端常量
	 */
	public static final String PC = "pc";
	
	/**
	 * 手机端常量
	 */
	public static final String PHONE = "phone";
	
	public static void main(String[] args) {
		System.out.println(INSERT_ARR.length);
	}
	
}
