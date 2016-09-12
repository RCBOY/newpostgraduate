package Servlet;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

/**
 * Created by 1234ztc on 2016/7/3.
 */
public class UploadHandleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession httpSession=request.getSession();
        String savepath = this.getServletContext().getRealPath("/WEB-INF/upload");
        String tempath = this.getServletContext().getRealPath("/WEB-INF/temp");
        System.out.print(tempath);
        File tempfile = new File(tempath);
        if (!tempfile.exists()) {
            tempfile.mkdir();
        }

        try {
            DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
            diskFileItemFactory.setSizeThreshold(1024 * 100);
            diskFileItemFactory.setRepository(tempfile);
            ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
            servletFileUpload.setProgressListener(new ProgressListener() {
                @Override
                public void update(long pBytesRead, long pContentLength, int arg2) {
                    System.out.println("文件大小为：" + pContentLength + ",当前已处理：" + pBytesRead);
                }
            });
            servletFileUpload.setHeaderEncoding("UTF-8");
            if (!ServletFileUpload.isMultipartContent(request)) {
                return;
            }
            servletFileUpload.setFileSizeMax(1024 * 1024);
            servletFileUpload.setSizeMax(1024 * 1024 * 10);
            List<FileItem> list = servletFileUpload.parseRequest(request);
            for(FileItem iterm:list){
                if (iterm.isFormField()){
                    String name=iterm.getFieldName();
                    String value=iterm.getString("UTF-8");
                    System.out.println(name+"="+value);
                }else {
                    String filename=iterm.getName();
//                    System.out.println(filename);
                    if (filename==null||filename.trim().equals("")){
                        continue;
                    }
                    String username=(String)httpSession.getAttribute("username");
                    filename=username+filename.substring(filename.lastIndexOf("\\")+1);
                    System.out.println("++"+filename);
                    String fileExname=filename.substring(filename.lastIndexOf(".")+1);
                    System.out.println("上传文件的扩展名为："+fileExname);
                    InputStream inputStream=iterm.getInputStream();
                    String saveFilename=makeFileName(filename);
                    String realSavePath=makePath(filename,savepath);
                    FileOutputStream out = new FileOutputStream(realSavePath + "\\" + saveFilename);
                    byte buffer[]=new byte[1024];
                    int len=0;
                    while((len=inputStream.read(buffer))>0){
                        out.write(buffer,0,len);
                    }
                    inputStream.close();
                    out.close();

                }
            }
            JOptionPane.showMessageDialog(null, "上传成功！", "提示", JOptionPane.PLAIN_MESSAGE);
//            request.getRequestDispatcher("/AboutStudentJsp/StudentUpload.jsp").forward(request, response);
        } catch (FileUploadBase.FileSizeLimitExceededException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "单个文件超出最大值！", "提示", JOptionPane.ERROR_MESSAGE);
            request.getRequestDispatcher("/Student.jsp").forward(request, response);
            return;
        }catch (FileUploadBase.SizeLimitExceededException e){
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "上传文件的总的大小超出限制的最大值！", "提示", JOptionPane.ERROR_MESSAGE);
            request.getRequestDispatcher("/Student.jsp").forward(request, response);
            return;
        }catch (Exception e){
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "上传文件失败！", "提示", JOptionPane.ERROR_MESSAGE);
            request.getRequestDispatcher("/Student.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("/Student.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    private String makeFileName(String filename){
        //为防止文件覆盖的现象发生，要为上传文件产生一个唯一的文件名
        return UUID.randomUUID().toString() + "_" + filename;
    }
    private String makePath(String filename,String savePath){
        //得到文件名的hashCode的值，得到的就是filename这个字符串对象在内存中的地址
        int hashcode = filename.hashCode();
        int dir1 = hashcode&0xf;  //0--15
        int dir2 = (hashcode&0xf0)>>4;  //0-15
        // 构造新的保存目录
        String dir = savePath + "\\" + dir1 + "\\" + dir2;  //upload\2\3  upload\3\5
        //File既可以代表文件也可以代表目录
        File file = new File(dir);
        //如果目录不存在
        if(!file.exists()){
            //创建目录
            file.mkdirs();
        }
        return dir;
    }
}
