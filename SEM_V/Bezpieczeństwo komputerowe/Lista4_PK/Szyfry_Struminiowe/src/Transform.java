import java.util.ArrayList;

public class Transform {
    String key = "00000000";
    int key_num = 0;

    //generowanie następnego klucza dla jednego znaku
    public void next_key(){
        key_num = (key_num+1)%256;
        String a = String.valueOf(Integer.toBinaryString(key_num));
        int d = a.length();
        key = "";

        if(d<8){
            for(int i=0;i<8-d;i++){
                key = key + "0";
            }
        }
        key = key + a;
    }

    //zmienia postac bin znakow na String
    public String bin_to_String(String bin){
        int size = bin.length();
        System.out.println(size);
        String b = "";
        String s = "";
        if(size%8==0){
            for(int i=0;i<size;i=i+8){
                for(int j=i;j<i+8;j++){
                    b = b+Character.toString(bin.charAt(j));
                }
                s = s + Character.toString((char)(Integer.parseInt(b,2)));
                b = "";
            }
        }
        return s;
    }

    //tworzy tablice zawierajaca pojedynczy znak(8 bitow) kazdego z kryptogramow
    public ArrayList sngleSign(ArrayList<String> list, int num){
        ArrayList sign = new ArrayList<String>();
        String b = "";

        for(int j=0;j<list.size();j++){
            for(int i=(num*8)-8;i<num*8;i++) {
                b = b+Character.toString((list.get(j)).charAt(i));
            }
            sign.add(b);
            b = "";
        }
        return sign;
    }

    //operacja XOR
    public String xor(String a, String b){
        String x = "";
        for(int i=0;i<8;i++){
            x = x + ((Integer.parseInt(Character.toString(a.charAt(i))) + Integer.parseInt(Character.toString(b.charAt(i))))%2);
        }
        return x;
    }
}

