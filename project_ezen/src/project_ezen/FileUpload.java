package project_ezen;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
//import java.util.Enumeration;
//import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
//import com.oreilly.servlet.MultipartRequest;

public class FileUpload {

    private static final String SAVE_DIR = "upload";

    public static int upload(HttpServletRequest request) throws IOException, ServletException {
    	
    	int result = 0;
        
        String appPath  = request.getServletContext().getRealPath("");
        String savePath = appPath +  SAVE_DIR;
        
        // 서버에 savePath에 해당하는 디렉토리가 있는지 확인해서 
        // 없으면 만든다
        File fileSaveDir = new File(savePath);
        if( !fileSaveDir.exists() ) {
            fileSaveDir.mkdir();
        }

        for (Part part : request.getParts()) {
            String fileName = extractFileName(part.getHeader("Content-Disposition"));
            System.out.println("fileName:"+fileName);
            System.out.println("savePath:"+savePath);
            part.write(savePath + File.separator + fileName);
            
			String ContextPath = request.getServletContext().getContextPath();
	        System.out.println("ContextPath:"+ContextPath);
	        
            request.setAttribute("fileFullPath", "http://localhost:8081" + ContextPath + "/" + SAVE_DIR + "/"+ fileName);
        }

        return result;
    }

    private static String extractFileName(String partHeader) {
        for (String cd : partHeader.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf("=") +  1).trim().replace("\"", "");;
                int index = fileName.lastIndexOf(File.separator);
                return fileName.substring(index + 1);
            }
        }
        return null;
    }
    

}
