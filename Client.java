
import java.io.*;
import java.net.*;

public class Client {

    public static void main(String[] args) throws IOException {

        String serverHostname = new String("localhost");
        if (args.length > 0) {
            serverHostname = args[0];
        }
        System.out.println("Attemping to connect to host "
                + serverHostname + " on port 10008.");
        Socket echoSocket = null;
        PrintWriter out = null;
        BufferedReader in = null;
        BufferedReader outTest = null;
        try {
            echoSocket = new Socket(serverHostname, 9992);
            out = new PrintWriter(echoSocket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(
                    echoSocket.getInputStream()));
        } catch (UnknownHostException e) {
            System.err.println("Don't know about host: " + serverHostname);
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Couldn't get I/O for "
                    + "the connection to: " + serverHostname);
            System.exit(1);
        }

        BufferedReader stdIn = new BufferedReader(
                new InputStreamReader(System.in));
        String userInput;
        System.out.println("Type Message (\"Bye.\" to quit)");
        while ((userInput = stdIn.readLine()) != null) {
            System.out.println("User input: " + userInput);
            out.println(userInput);
            //if (userInput.equals("Bye")) {
              //  break;
           // }
            userInput = in.readLine();
            String[] userInputElements = userInput.split(",");
            for (String name : userInputElements) {
                System.out.println(name);
            }
            //System.out.println(userInput);
            System.out.println("breakpoint reached!");
        }
        out.close();
        in.close();
        stdIn.close();
        echoSocket.close();
    }
}

