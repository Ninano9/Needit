package web.util;

public class Paging {
	
	private String menu;	//조회할 메뉴
	private String cate;	//조회할 카테고리
	private String selectSub; 	//선택된 검색주제
	private String searchText; 	//입력받은 검색값
	private int curPage;	//현재 페이지 번호
	private int totalCount;	//총 게시글 수
	private int listCount;	//한 페이지 당 보여질 게시글 수
	private int totalPage;	//총 페이지의 수
	private int pageCount;	//한 화면에 출력될 페이지네이션의 개수
	private int startPage;	//화면에 보이는 시작 페이지네이션의 번호
	private int endPage;	//화면에 보이는 끝 페이지네이션의 번호
	private int startNo;	//화면에 보이는 게시글의 시작 번호 
	private int endNo;		//화면에 보이는 게시글의 끝 번호
	private String userId;
	
	public Paging() {}

	//총 게시글 수, 현재 페이지 번호를 입력하는 생성자
	public Paging(String menu, String cate, int totalCount, int curPage) {
		setMenu(menu);
		setCate(cate);
		setTotalCount(totalCount);
		setCurPage(curPage);
		
		makePaging();
	}
	
	//총 게시글수, 현재 페이지 번호, 보여질 게시글수, 보여질 페이지 수 를 입력하는 생성자
	public Paging(String menu, String cate, int totalCount, int curPage, int listCount, int pageCount) {
		setMenu(menu);
		setCate(cate);
		setTotalCount(totalCount);
		setCurPage(curPage);
		setListCount(listCount);
		setPageCount(pageCount);
		
		makePaging();
	}
	
	//총 게시글수, 현재 페이지 번호, 보여질 게시글수, 보여질 페이지 수 를 입력하는 생성자
	public Paging(String menu, String cate, String selectSub, String searchText, int totalCount, int curPage, int listCount, int pageCount) {
		setMenu(menu);
		setCate(cate);
		setSelectSub(selectSub);
		setSearchText(searchText);
		setTotalCount(totalCount);
		setCurPage(curPage);
		setListCount(listCount);
		setPageCount(pageCount);
		
		makePaging();
	}
	
	//페이징 처리 정보를 생성하는 메소드
	private void makePaging() {
		if(totalCount == 0)		return;	//게시글이 없을 경우 중단한다
		
		if(curPage == 0)	setCurPage(1);		//1 페이지를 기본 페이지로 설정한다
		if(listCount == 0)	setListCount(10);	//화면에 보일 게시글 수(10)의 기본값 설정
		if(pageCount == 0)	setPageCount(10);	//화면에 보일 페이징 수(10)의 기본값 설정
		
		//총 페이지 수 계산
		totalPage = totalCount / listCount;
		if( totalCount % listCount > 0 )	totalPage++;
		
		//현재 페이지값 보정
		if( curPage > totalPage )	curPage = totalPage;
		
		//화면에 보여질 페이지네이션의 시작 번호와 끝 번호
		startPage = ((curPage-1)/pageCount) * pageCount + 1;
		endPage = startPage + pageCount - 1;
		
		//끝 페이지 보정
		if( endPage > totalPage )	endPage = totalPage;
		
		//화면에 보여질 게시글의 시작 번호와 끝 번호
		startNo = (curPage-1) * listCount + 1;
		endNo = curPage * listCount;
	}

	@Override
	public String toString() {
		return "Paging [menu=" + menu + ", cate=" + cate + ", curPage=" + curPage + ", totalCount=" + totalCount
				+ ", listCount=" + listCount + ", totalPage=" + totalPage + ", pageCount=" + pageCount + ", startPage="
				+ startPage + ", endPage=" + endPage + ", startNo=" + startNo + ", endNo=" + endNo + ", selectSub="
				+ selectSub + ", searchText=" + searchText + "]";
	}
	

	public int getCurPage() {
		return curPage;
	}


	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getListCount() {
		return listCount;
	}

	public void setListCount(int listCount) {
		this.listCount = listCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getStartNo() {
		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	
	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate= cate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSelectSub() {
		return selectSub;
	}

	public void setSelectSub(String selectSub) {
		this.selectSub = selectSub;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}	

}
