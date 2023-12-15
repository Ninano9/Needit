package web.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.UserDao;
import web.dto.User;
import web.service.face.UserService;

@Service
public class UserServiceImpl implements UserService {

	private final Logger logger = LoggerFactory.getLogger( this.getClass() );

	@Autowired UserDao userDao;
	
	@Override
	public void join(User user) {
	
		userDao.insertJoin(user);
	}

	@Override
	public boolean login(User user) {
		int result = userDao.selectCntByIdPw(user);
		
		if( result > 0) {
			return true;
		}
		
		
		return false;
	}

	@Override
	public User infoNick(User user) {
		return userDao.selectByNick(user);
	}

	@Override
	public boolean idCheck(User user) {
		int result = userDao.selectCntById(user);
		
		if( result > 0) {
			return true;
		}
		
		
		return false;
	}

	@Override
	public boolean ncikCheck(User user) {
		int result = userDao.selectCntByNick(user);
		
		if( result > 0) {
			return true;
		}
		
		return false;
	}

	@Override
	public boolean social(User user) {
		int result = userDao.selectCntBySocialId(user);
		
		if( result > 0) {
			return true;
		}
		
		return false;
	}

	@Override
	public User socialinfo(User user) {
		return userDao.selectByInfo(user);
		
	}

	@Override
	public List<User> findid(User user) {
		return userDao.selectById(user);
	}

	@Override
	public User findpw(User user) {
		return userDao.selectByPw(user);
	}

	@Override
	public void pwChange(User user) {
		
		userDao.updateByPw(user);
	}


}
