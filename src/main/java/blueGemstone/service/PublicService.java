package blueGemstone.service;

import java.util.List;

import blueGemstone.entity.VarChange;

public interface PublicService {

	int insertVarChange();

	int insertVarAvgChange();

	List<VarChange> selectVarChangeLineData();

}
