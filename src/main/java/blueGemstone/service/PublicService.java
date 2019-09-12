package blueGemstone.service;

import java.util.List;
import java.util.Map;

import blueGemstone.entity.LoginRecord;
import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.VarWarnLimit;
import blueGemstone.entity.WarnHistoryRecord;
import blueGemstone.entity.WarnRecord;

public interface PublicService {

	Integer insertVarChange(List<VarWarnLimit> vwlList, String pushData);
	
	Integer insertVarChangeTest();

	Integer insertVarAvgChange(List<VarWarnLimit> vwlList, Integer timeFlag);

	Integer insertVarAvgChangeTest(Integer timeFlag);
	
	Integer insertWarnRecord(VarChange varChange);

	List<VarChange> selectVarChangeLineData(String name, int page, int row);

	int getVarChangeReportDataCount(String name);

	List<VarChange> selectVarChangeReportData(String name, int page, int rows);

	List<VarAvgChange> selectVarAvgChangeLineData(String name, String timeSpace, String startTime, String endTime, int page, int rows);

	List<WarnRecord> selectWarnRecordReportData(String name);

	List<WarnHistoryRecord> selectWarnHistoryRecordReportData(String name);

	Integer updateWarnRecord();

	List<Map<String, Object>> getCurrentVarValueList();

	List<VarWarnLimit> selectVarWarnLimitData();

	Integer insertLoginRecord(LoginRecord loginRecord);

	LoginRecord selectLastLoginRecordByName(String name);

}
