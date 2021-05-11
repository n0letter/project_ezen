package project_ezen;

public class ContextPath {
	 private static ContextPath instance;
     private final String path;

     public static void createInstance(String path){
    	 instance = new ContextPath(path);
    }

    private ContextPath(String path){
    	this.path=path;
    }

    public static ContextPath getInstance(){
    	if(instance==null)
    		throw new NullPointerException();
        else
        	return instance;
    }

    public String getPath(){
    	return path;
     }
}
