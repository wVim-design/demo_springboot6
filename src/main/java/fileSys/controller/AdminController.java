package fileSys.controller;

import com.alibaba.fastjson.JSON;
import fileSys.bean.*;
import fileSys.service.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping(value = "/adminController")
public class AdminController {
    @RequestParam
    @Resource
    private AdminService adminService;
    @Autowired
    private UserService userService;
    @Resource
    private FileService fileService;
    @Autowired
    private TypeService typeService;
    @Autowired
    private LevelService levelService;
    @Autowired
    private ScoreRecService scoreRecService;


    @RequestMapping(value = "/login",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        String password = request.getParameter("password");

        Admin admin = adminService.login(account);
        int res = 0;
        if(admin==null){
            System.out.println("账号错误");
            res = 0;
        }else{
            if(!admin.getPassword().equals(password)){
                System.out.println("密码错误");
                res = 1;
            }else{
                System.out.println("密码正确");
                request.getSession().setAttribute("admin",admin);
                List<Menu> menuList = adminService.findMenuList(admin.getId());
                request.getSession().setAttribute("menuList",menuList);
                res = 2;
            }
        }
        return res+"返回的消息";

    }

    @RequestMapping(value = "/findAdminList",produces="text/html;charset=UTF-8")
    @ResponseBody
    public Object findAdminList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String curPage = request.getParameter("curPage");
        String pageSize = request.getParameter("pageSize");
        int curPage1 = Integer.parseInt(curPage);
        int pageSize1 = Integer.parseInt(pageSize);
        int offset1 = (curPage1-1)*pageSize1;
        return JSON.toJSONString(adminService.findAdminList(pageSize1,offset1));

    }

    @RequestMapping(value = "/findUserList",produces="text/html;charset=UTF-8")
    @ResponseBody
    public Object findUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String curPage = request.getParameter("curPage");
        String pageSize = request.getParameter("pageSize");
        String name = request.getParameter("name");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        int curPage1 = Integer.parseInt(curPage);
        int pageSize1 = Integer.parseInt(pageSize);
        int offset1 = (curPage1-1)*pageSize1;

        HashMap<String,Object> condition = new HashMap<>();
        condition.put("offset",offset1);
        condition.put("pageSize",pageSize1);
        condition.put("name",name);
        condition.put("startTime",startTime);
        condition.put("endTime",endTime);

        return JSON.toJSONString(userService.findUserList(condition));
    }

    @RequestMapping(value = "/changeUserStatus",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String changeUserStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String statusId = request.getParameter("statusId");
        return userService.changeUserStatus(statusId,id)+"";
    }

    @RequestMapping(value = "/findFileType",produces="text/html;charset=UTF-8")
    @ResponseBody
    public Object findFileType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return JSON.toJSONString(typeService.findFileType());
    }

    @RequestMapping(value = "/findFileList",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String findFileList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String curPage = request.getParameter("curPage");
        String pageSize = request.getParameter("pageSize");
        String name = request.getParameter("name");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String typeId = request.getParameter("typeId");
        int curPage1 = Integer.parseInt(curPage);
        int pageSize1 = Integer.parseInt(pageSize);
        int offset1 = (curPage1-1)*pageSize1;
        HashMap<String,Object> condition = new HashMap<>();
        condition.put("offset",offset1);
        condition.put("pageSize",pageSize1);
        condition.put("name",name);
        condition.put("startTime",startTime);
        condition.put("endTime",endTime);
        condition.put("typeId",typeId);

        return JSON.toJSONString(fileService.findFileList(condition));
    }

    @RequestMapping(value = "/changeFileStatus",produces="text/html;charset=UTF-8")
    @ResponseBody
    @Transactional
    public String changeFileStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String statusId = request.getParameter("statusId");
        String suffix = request.getParameter("typeId");
        if(statusId.equals("2")){//
            User user = (User) request.getSession().getAttribute("user");
//            MyFile file = fileService.findFileById(Integer.parseInt(id));
//            User user =
            Admin admin = (Admin) (request.getSession().getAttribute("admin"));
            Level level = levelService.findLevelById(user.getLevelId());
            Type type = typeService.findTypeBySuffix(suffix);
            int realAddScore= (int) (type.getUploadScore()*level.getUpRatio());

            ScoreRec scoreRec = new ScoreRec();
            scoreRec.setFileId(Integer.parseInt(id));
            scoreRec.setType("上传");
            scoreRec.setUserId(user.getId());
            scoreRec.setScore(realAddScore);
            int res = scoreRecService.insertScoreRec(scoreRec);
//            int jj =100/0;
            int res2 = userService.updateUserForUpload(user.getId(),realAddScore);
        }
        return fileService.changeFileStatus(statusId,id)+"";
    }

    @RequestMapping(value = "/changeTypeStatus",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String changeTypeStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Type> typeList = JSON.parseArray(request.getParameter("json"),Type.class);

        return typeService.changeTypeStatus(typeList)+"";
    }

    @RequestMapping(value = "/findLevelList",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String findLevelList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String curPage = request.getParameter("curPage");
        String pageSize = request.getParameter("pageSize");
        int curPage1 = Integer.parseInt(curPage);
        int pageSize1 = Integer.parseInt(pageSize);
        int offset1 = (curPage1-1)*pageSize1;
        HashMap<String,Object> condition = new HashMap<>();
        condition.put("offset",offset1);
        condition.put("pageSize",pageSize1);
        return JSON.toJSONString(levelService.findLevelList(condition));
    }

    @RequestMapping(value = "/editLevel",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String editLevel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Level level = JSON.parseObject(request.getParameter("json"),Level.class);

        return levelService.editLevel(level)+"";
    }

    @RequestMapping(value = "/addLevel",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String addLevel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Level level = JSON.parseObject(request.getParameter("json"),Level.class);
        return levelService.addLevel(level)+"";

    }

    @RequestMapping(value = "/addType",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String addType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Type type = JSON.parseObject(request.getParameter("json"),Type.class);
        return typeService.addType(type)+"";
    }

    @RequestMapping(value = "/findJournalList",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String findJournalList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String curPage = request.getParameter("curPage");
        String pageSize = request.getParameter("pageSize");
        String adminAccount = request.getParameter("adminAccount");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        int curPage1 = Integer.parseInt(curPage);
        int pageSize1 = Integer.parseInt(pageSize);
        int offset1 = (curPage1-1)*pageSize1;
        HashMap<String,Object> condition = new HashMap<>();
        condition.put("offset",offset1);
        condition.put("pageSize",pageSize1);
        condition.put("adminAccount",adminAccount);
        condition.put("startTime",startTime);
        condition.put("endTime",endTime);

        return JSON.toJSONString(adminService.findJournalList(condition));
    }

    @RequestMapping(value = "/deleteJournal",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String deleteJournal(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        return adminService.deleteJournal(Integer.parseInt(id))+"";
    }

}
