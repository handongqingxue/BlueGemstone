package blueGemstone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import blueGemstone.entity.LoginRecord;
import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.VarWarnLimit;
import blueGemstone.entity.WarnHistoryRecord;
import blueGemstone.entity.WarnRecord;

public interface PublicMapper {

	Integer select();

	Integer insertVarChange(VarChange varChange);

	Integer insertVarAvgChange(VarAvgChange varAvgChange);

	Float getVarChangeAvgValue(@Param("name") String name, @Param("time") String time, @Param("timeFlag") Integer timeFlag);

	Integer updateVarChange(@Param("name") String name, @Param("time") String time, @Param("timeFlag") Integer timeFlag);

	List<VarChange> selectVarChangeLineData(@Param("name") String name, @Param("page") int page, @Param("row") int row);

	Integer getVarChangeReportDataCount(@Param("name") String name);

	List<VarChange> selectVarChangeReportData(@Param("name") String name, @Param("page") int page, @Param("rows") int rows);

	List<VarAvgChange> selectVarAvgChangeLineData(@Param("name") String name, @Param("timeSpace") String timeSpace, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("page") int page, @Param("rows") int rows);

	List<WarnRecord> selectWarnRecordReportData(@Param("name") String name);

	Integer insertWarnRecord(WarnRecord warnRecord);

	Integer insertWarnHistoryRecord(WarnHistoryRecord whr);

	Integer getVarStateByName(@Param("name") String name);

	Integer deleteVarChange();

	Integer deleteWarnRecordByName(@Param("name") String name);

	int getWarnHistoryRecordReportDataCount(@Param("name") String name);

	List<WarnHistoryRecord> selectWarnHistoryRecordReportData(@Param("name") String name, @Param("page") int page, @Param("rows") int rows);

	List<VarChange> getCurrentVar();

	List<VarWarnLimit> selectVarWarnLimitData();

	Integer insertLoginRecord(LoginRecord loginRecord);

	LoginRecord selectLastLoginRecordByName(@Param("name") String name);

	int getWarnRecordCount();

	VarWarnLimit getRange(@Param("name") String name);

}
