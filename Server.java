
import java.net.*;
import java.io.*;
import java.util.concurrent.atomic.AtomicLong;

public class Server extends Thread {

    protected Socket clientSocket;

    public static void main(String[] args) throws IOException {

        ServerSocket serverSocket = null;

        try {
            serverSocket = new ServerSocket(9992);
            System.out.println("Connection Socket Created");
            try {
                while (true) {
                    System.out.println("Waiting for Connection");
                    new Server(serverSocket.accept());
                }
            } catch (IOException e) {
                System.err.println("Accept failed.");
                System.exit(1);
            }
        } catch (IOException e) {
            System.err.println("Could not listen on port: 10008.");
            System.exit(1);
        } finally {
            try {
                serverSocket.close();
            } catch (IOException e) {
                System.err.println("Could not close port: 10008.");
                System.exit(1);
            }
        }
    }
    private static AtomicLong idCounter = new AtomicLong();
    private long clientid = idCounter.incrementAndGet();

    private Server(Socket clientSoc) {
        clientSocket = clientSoc;
        start();
    }

    public void run()  {
		//throw new IllegalArgumentException();
        System.out.println("New Communication Thread Started");
        PrintWriter out = null;
        BufferedReader in = null;
        try {

            out = new PrintWriter(clientSocket.getOutputStream(), true);
            in = new BufferedReader(
                    new InputStreamReader(clientSocket.getInputStream()));

            String inputLine=null;
            String s = null;

            StringBuilder sb = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                System.out.println("Client " + clientid + ":" + inputLine);
                // out.println(inputLine);
                try {
                    Process p = Runtime.getRuntime().exec(inputLine);

                    BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));

                    s = stdInput.readLine();
                    do {
                        sb.append(s);
                        sb.append(",");
                        s = stdInput.readLine();
                    } while (s != null);
                    out.println(sb.toString());
                    System.out.println("Breaked ");
                    sb.delete(0, sb.length());
                    //if (inputLine.equals("Bye")) {
                      //break;
                    //}
                } catch (IllegalArgumentException e) {
			//e.printStackTrace(System.err);
			 System.err.println("Command Not Found");
			out.println("Command Not Found");
                  
                }
		catch (Exception e) {	
                    System.err.println("Command Not Found");
		  out.println("Command Not Found");
                    //System.exit(1);
                }
            }
        } catch (IOException e) {
            System.err.println("Problem with Communication Server");
           System.exit(1);
        }
        try {
            out.close();
            in.close();
            clientSocket.close();
        } catch (Exception ee) {
        }

    }

}
