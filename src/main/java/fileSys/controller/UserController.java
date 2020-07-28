package fileSys.controller;


import com.alibaba.fastjson.JSON;
import fileSys.bean.*;
import fileSys.bean.MyFile;
import fileSys.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

@Controller
@RequestMapping(value = "/userController")
public class UserController {

    @Autowired
    private AdminService adminService;
    @Autowired
    private UserService userService;
    @Autowired
    private FileService fileService;
    @Autowired
    private TypeService typeService;
    @Autowired
    private LevelService levelService;
    @Autowired
    private ScoreRecService scoreRecService;

    @RequestMapping(value = "/accTest")
    @ResponseBody
    public String accTest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        return userService.accTest(account)+"";
    }

    @RequestMapping(value = "/register")
    @ResponseBody
    public String register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user= JSON.parseObject(request.getParameter("user"),User.class);
//        int Score =
//        int a = userService.register(user);
//        ScoreRec scoreRec = new ScoreRec();
//        scoreRec.setUserId(user.getId());
//        scoreRec.setScore();
//        int b = scoreRecService.insertScoreRec();
        return "";

    }

    @RequestMapping(value = "/login")
    @ResponseBody
    public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        String password = request.getParameter("password");

        User user = userService.login(account);
        int res = 0;
        if(user==null){
            System.out.println("账号错误");
            res = 0;
        }else{
            if(!user.getPassword().equals(password)){
                System.out.println("密码错误");
                res = 1;
            }else{
                System.out.println("密码正确");
                request.getSession().setAttribute("user",user);
                res = 2;
            }
        }
        return res+"";
    }


    @RequestMapping(value = "/findUserInfo")
    @ResponseBody
    public String findUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        UserInfo userInfo = userService.findUserInfo(user.getId());
        return JSON.toJSONString(userInfo);

    }

    @RequestMapping(value = "/findFileList",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String findFileList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String curPage = request.getParameter("curPage");
        String pageSize = request.getParameter("pageSize");
        String name = request.getParameter("name");
        User user = (User) request.getSession().getAttribute("user");
        int curPage1 = Integer.parseInt(curPage);
        int pageSize1 = Integer.parseInt(pageSize);
        int offset1 = (curPage1-1)*pageSize1;
        HashMap<String,Object> condition = new HashMap<>();
        condition.put("offset",offset1);
        condition.put("pageSize",pageSize1);
        condition.put("name",name);
        condition.put("statusId",2);//审核通过的文件才能找到，不分用户
        return JSON.toJSONString(fileService.findFileList(condition));
    }


    @RequestMapping(value = "/findMyFileList",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String findMyFileList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String curPage = request.getParameter("curPage");
        String pageSize = request.getParameter("pageSize");
        User user = (User) request.getSession().getAttribute("user");
        int curPage1 = Integer.parseInt(curPage);
        int pageSize1 = Integer.parseInt(pageSize);
        int offset1 = (curPage1-1)*pageSize1;
        HashMap<String,Object> condition = new HashMap<>();
        condition.put("offset",offset1);
        condition.put("pageSize",pageSize1);
        condition.put("userId",user.getId());//用户上传的文件，不分审核状态
        return JSON.toJSONString(fileService.findFileList(condition));
    }

    @RequestMapping(value = "/modifyMsg")
    @ResponseBody
    public int modifyMeg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserInfo userInfo= JSON.parseObject(request.getParameter("userInfo"),UserInfo.class);
        int userId =((User) request.getSession().getAttribute("user")).getId();
        userInfo.setId(userId);
        return userService.modifyMsg(userInfo);
    }

    @RequestMapping(value = "/upload",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String upload(HttpServletRequest request, HttpServletResponse response, MultipartFile file) throws ServletException, IOException {
        int downloadScore = Integer.parseInt(request.getParameter("downloadScore"));
        System.out.println(downloadScore);
        try {
            //获取文件名
            String originalName = file.getOriginalFilename();
            //获取扩展名
            String suffix = originalName.substring(originalName.lastIndexOf(".") + 1);
            //使用UUID+后缀名保存文件名，防止中文乱码问题
            String uuid = UUID.randomUUID() + "";
            Date date = new Date();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String dateStr = simpleDateFormat.format(date);
            String savePath = request.getSession().getServletContext().getRealPath("/upload");
            //最终实际保存路径
            String filePath = savePath + File.separator+ dateStr + File.separator + uuid + "." + suffix;
            System.out.println("filePath==" + filePath);
            File files = new File(filePath);
            //打印查看上传路径
            if (!files.getParentFile().exists()) {//判断目录是否存在，否则创建父目录
                files.getParentFile().mkdirs();
            }
            file.transferTo(files); // 将接收的文件保存到指定文件中



            User user = (User)(request.getSession().getAttribute("user"));
            Type type = typeService.findTypeBySuffix(suffix);

            MyFile myFile = new MyFile();
            myFile.setName(file.getOriginalFilename());
            myFile.setDownloadScore(downloadScore);
            myFile.setDescription("不错");
            myFile.setTypeId(type.getId());
            myFile.setUserId(user.getId());
            myFile.setPath(filePath);
            int fileId = fileService.insertFile(myFile);


            LayuiData layuiData=new LayuiData();
            layuiData.setCode(0);
            layuiData.setMsg("上传成功");
            return JSON.toJSONString(layuiData);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @RequestMapping(value = "/beforeDownload",produces="text/html;charset=UTF-8")
    @ResponseBody
    public int beforeDownload (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = (User) request.getSession().getAttribute("user");

        int res = scoreRecService.hasDownloaded(id,user.getId());//判断是否有下载过
        if(res==0){//数量为0为没下载过
            MyFile myFile = fileService.findFileById(id);
            Level level = levelService.findLevelById(user.getLevelId());
            int realNeedScore = (int) (myFile.getDownloadScore()*level.getDownRatio());
            if(user.getScore()<realNeedScore){
                return -1;//不可下载用-1表示
            }else{
                return realNeedScore;//需要n分
            }
        }
        return 0;//需要0分

    }

    @RequestMapping(value = "/download",produces="text/html;charset=UTF-8")
    @ResponseBody
    public void download(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       //先扣用户分并插入明细表
        int id = Integer.parseInt(request.getParameter("id"));
        int realNeedScore = Integer.parseInt(request.getParameter("realNeedScore"));
        User user = (User) request.getSession().getAttribute("user");
        ScoreRec scoreRec = new ScoreRec();
        scoreRec.setScore(realNeedScore);
        scoreRec.setType("下载");
        scoreRec.setUserId(user.getId());
        scoreRec.setFileId(id);
        scoreRecService.insertScoreRec(scoreRec);
        userService.updateUserForDownload(user.getId(),realNeedScore);


        //输出文件
        MyFile myFile = fileService.findFileById(id);

        String filePath = request.getSession().getServletContext().getRealPath("/upload");// 获取真实路径
        String downloadFilename =myFile.getName();// 在下载框默认显示的文件名
        downloadFilename = URLEncoder.encode(downloadFilename, "UTF-8");// 对默认下载的文件名编码。不编码的结果就是，在客户端下载时文件名乱码
        File file = new File(myFile.getPath());
        if (file.exists()) {
            // 写明要下载的文件的大小
            response.setContentLength((int) file.length());
            response.setHeader("Content-Disposition", "attachment;filename=" + downloadFilename);// 设置在下载框默认显示的文件名
            response.setContentType("application/octet-stream");// 指明response的返回对象是文件流
            // 读出文件到response
            // 这里是先需要把要把文件内容先读到缓冲区
            // 再把缓冲区的内容写到response的输出流供用户下载
            FileInputStream fileInputStream = new FileInputStream(file);
            BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream);
            byte[] b = new byte[bufferedInputStream.available()];
            bufferedInputStream.read(b);
            OutputStream outputStream = response.getOutputStream();
            outputStream.write(b);
            // 缓冲和关闭流
            bufferedInputStream.close();
            outputStream.flush();
            outputStream.close();
     }
    }

    @RequestMapping(value = "/findScoreList",produces="text/html;charset=UTF-8")
    @ResponseBody
    public String findScoreList (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String curPage = request.getParameter("curPage");
        String pageSize = request.getParameter("pageSize");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        int curPage1 = Integer.parseInt(curPage);
        int pageSize1 = Integer.parseInt(pageSize);
        int offset1 = (curPage1-1)*pageSize1;
        HashMap<String,Object> condition = new HashMap<>();
        condition.put("offset",offset1);
        condition.put("pageSize",pageSize1);
        condition.put("startTime",startTime);
        condition.put("endTime",endTime);
        condition.put("userId",user.getId());
        return JSON.toJSONString(scoreRecService.findScoreList(condition));

    }


}
