import java.sql.*;


public class Main {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sheep", "postgres", "3066");
        Statement st = con.createStatement();
        System.out.println(st);
        con.setAutoCommit(false);



        ResultSet rs= st.executeQuery("select name, name_subject,  mark from student join progress p on (student.id_student = p.id_student) join public.subject s on p.id_subject = s.id_subject\n" +
                "where mark>3 offset 1 limit 3;");
        while (rs.next()){
            System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getInt(3));
        }
    }
}
