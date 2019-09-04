package blueGemstone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import blueGemstone.entity.VarAvgChange;
import blueGemstone.entity.VarChange;
import blueGemstone.entity.WarnHistoryRecord;
import blueGemstone.entity.WarnRecord;

public interface PublicMapper {

	Integer select();

	Integer insertVarChange(VarChange varChange);

	Integer insertVarAvgChange(VarAvgChange varAvgChange);

	Float getVarChangeAvgValue(@Param("name") String name, @Param("time") String time);

	Integer updateVarChange(@Param("name") String name, @Param("time") String time);

	List<VarChange> selectVarChangeLineData(@Param("name") String name, @Param("page") int page, @Param("row") int row);

	List<VarChange> selectVarChangeReportData(@Param("name") String name);

	List<VarAvgChange> selectVarAvgChangeLineData(@Param("name") String name, @Param("page") int page, @Param("row") int row);

	List<WarnRecord> selectWarnRecordReportData(@Param("name") String name);

	Integer insertWarnRecord(WarnRecord warnRecord);

	Integer insertWarnHistoryRecord(WarnHistoryRecord whr);

	Integer getVarStateByName(@Param("name") String name);

	Integer deleteWarnRecordByName(@Param("name") String name);

	List<WarnHistoryRecord> selectWarnHistoryRecordReportData(@Param("name") String name);

	Float getCurrentVarValue(@Param("name") String name);

}
