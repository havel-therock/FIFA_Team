import java.util.*;
import java.util.*;
import java.io.IOException;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;
import java.nio.charset.Charset;
import java.nio.charset.CharsetEncoder;


public class Decrpty{

    static CharsetEncoder asciiEncoder = 
    Charset.forName("US-ASCII").newEncoder(); // or "ISO-8859-1" for ISO Latin 1

public static boolean isPureAscii(String v) {
  return asciiEncoder.canEncode(v);
}
    public static void main(String[] args){

        
        String[] arrayOfHexMessages = new String[20];
        try{
            read(arrayOfHexMessages);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
     /* String[] arrayOfHexMessages = new String[11]; 
         arrayOfHexMessages[0] = "1D1C4554250A111200244E04001C1100490B0B413F540E0844030005560C015941541C591E19041A164916504B1116000E19154F170711050445154F105500480F55161A43130A50191C0C06001B09001618040D10521A1E49174F440E0113";
        arrayOfHexMessages[1] = "0C1A4306181B111A4F0F000E0145151C4544151303430A1553421D0756001C1A4F10064E1454004E0945060341130A00061B5253100D0D4D084504411B5515534A011C54480817454D1C171B0017004E07110F1A17";
        arrayOfHexMessages[2] = "1D1C4506044B0401454154101D45150D5001164103464F034E01001806111B164E540E4C141B130710481850530D024D0A010049064E00030A170A50161C1B4E4A141D10000000590018061C521D0C00161A021C1D5001194F1A";
        arrayOfHexMessages[3] = "1D1C4554370202164E045202520608044801174105534F07000F17151E0A16594F124F451D17131714541C1E47540E4C1F1D1342001A0C0E49111658165516594A00001D4E0653414D06061A49111C001C12410A0D461315521101544F36134515131B450D0D03";
        arrayOfHexMessages[4] = "1A00521B0F0C4517490649131309410749030B0018551D03534213131345131700111C53161A1507054C550245051A491D101F450B1A450B06175353071601520F55000D5315164D1E";
        arrayOfHexMessages[5] = "0C02451A411F0D1600124D061E090407544415041E5300080001130F56061A184E130A00071C044E074F000253114F4F09550648004E03181D100145";
        arrayOfHexMessages[6] = "1D1C4554220A0000411300041B1509115244040D1F4F4F0D4E0D050F5604015941541C481A12154E0749051845064F491C551D4E004E0A0B49111B4542061D4D1A1916075441154F1F1810484F124F451D17131714541C1F4E";
        arrayOfHexMessages[7] = "1B2761540818451E410545471D0341004801450802491B0F410E520D1311061C52074F4F1554150601000605521A0E4D0A06524F034E370207452149141007544A34171D00321B41001C1148411A0B003F110E00055211506110034502141C";
        arrayOfHexMessages[8] = "1D1C455411190A074F024F0B52120007000A040C09444F0746161713562E170B42111D4F0054071C0B4D553752110A4B4F180B540D0109020E1C53540A1054460F071C17490E06534D010B1A45114F481615050B0000120541060B000B1A15000914492D0F0016";
        arrayOfHexMessages[9] = "1B114D110C09000100154F471E0A0E1F001115410D544F12480752120204000A00150144531A0E1A44441A074E540E544F0C1D55174E03080C1153410C11544E0F03160600061A56085516180003005218";

        arrayOfHexMessages[10] = "0B184F170A4B061A50094515014515154B0145004C4E1A0B420700411903521B49001C00121A054E014E160259041B001B1D174D450F164D084500490C1218454A001D1D5441124E095513094410064E145415060100051C411D01540A0D0600151D4911060507";
*/
       // String secretMessageHex = "0B184F170A4B061A50094515014515154B0145004C4E1A0B420700411903521B49001C00121A054E014E160259041B001B1D174D450F164D084500490C1218454A001D1D5441124E095513094410064E145415060100051C411D01540A0D0600151D4911060507";
       // String secretMessage = hexToString(secretMessageHex);
        //System.out.println(secretMessage);
        String[] arrayOfASCIIEncMessages = hexToString(arrayOfHexMessages); // converting all the hex to ASCII
        StringXORer stringXORer = new StringXORer();
        HashMap<Integer,String> finalKeyNonHex = new HashMap<>();
        Set<Integer> knownKeyPositiosn = new TreeSet<>();
        String[] finalKey = new String[1000];
        Boolean bool = false;


        for(int i =  0; i < arrayOfASCIIEncMessages.length; i++){
            HashMap<Integer, Integer> counter = new HashMap();
            ArrayList<Integer> knownSpaceIndex = new ArrayList();

            for(int j = 0; j < arrayOfASCIIEncMessages.length; j++){
                if(!(i==j)){ //we cannot be testing a cipher against itself

                    String xorResult = stringXORer.encode(arrayOfASCIIEncMessages[i],arrayOfASCIIEncMessages[j]);
                  /*  if(!bool){
                        System.out.println(stringXORer.encode(xorResult,"encryption is the process of encoding a message in such a way as to hide its content"));
                        bool = true;
                    } */
                  //  System.out.println(arrayOfASCIIEncMessages[j].length());
                    for(int k = 0; k < xorResult.length();k++){

                        //now we check if the result is an ASCII character
                        if(isCharASCIIAlphabet(String.valueOf(xorResult.charAt(k)))){
                            if(!counter.containsKey(k)){
                                counter.put(k, 1);
                            } else {
                                counter.put(k,counter.get(k) + 1);
                            }
                        }

                    }
                }
            }

            Iterator it = counter.entrySet().iterator();
            while(it.hasNext()){
                Map.Entry pair = (Map.Entry)it.next();
                //if the count is likely above 6 then we can say this is probably the right character for the key
                if((Integer)pair.getValue() > 12){
                    knownSpaceIndex.add((Integer)pair.getKey());
                }
            }

            //if we xor string with spaces we can then output the key
            String xorWithSpaces = stringXORer.encode(arrayOfASCIIEncMessages[i],generateSpaceString(arrayOfASCIIEncMessages[i]));
            for(int l : knownSpaceIndex){
                if(!bool){
               System.out.println("Xxxxxxxxxx");
               String xorResult = stringXORer.encode(arrayOfASCIIEncMessages[0],arrayOfASCIIEncMessages[1]);
               System.out.println(xorResult.length());
               System.out.println(xorWithSpaces.length());
               try{
                   System.out.println(arrayOfASCIIEncMessages[i].getBytes().length);
                   System.out.println(generateSpaceString(arrayOfASCIIEncMessages[i]).getBytes().length);
                }catch(Exception ex){
                   System.out.println("Unsupported character set" + ex);
                }
             
              bool=true;
                }
                finalKey[l] = String.valueOf(xorWithSpaces.charAt(l));
                knownKeyPositiosn.add(l);

            }
        }

        StringBuilder sb1 = new StringBuilder();
        StringBuilder sb2 = new StringBuilder();
        int s = 0;
        System.out.println(finalKey.length);
        for(int m = 0; m < finalKey.length; m++){
            if(finalKey[m] != null){
                sb1.append(finalKey[m]);
                sb2.append(finalKey[m]);
            } else {
                sb1.append("*");
                sb2.append((char)s);
            }
        }

        String manualKeyGuess = "it takes a great deal of bravery to stand up to our enemies but just as much to stand up to our friends";

        manualKeyGuess.replace("*",String.valueOf((char)s));


        System.out.println("key is : " + sb1.toString());
        System.out.println();
        for(int i = 0; i < arrayOfASCIIEncMessages.length; i++){
            System.out.println("Message " + i + " is: " +createSplitStringArray(arrayOfASCIIEncMessages[i],sb1.toString()));
        }
      /*  System.out.println("Message " + 1 + " is: " +createSplitStringArray(arrayOfASCIIEncMessages[1],sb1.toString()));
        String xorResult;
        String key="miesiace";
        for(int i=0;i<8;i++){
            xorResult = stringXORer.encode(arrayOfASCIIEncMessages[1],key);
            System.out.println("!!!!!!!! UWAGA : " + xorResult);
            key = " " + key;
        }*/


        //System.out.println("message is : " + createSplitStringArray(arrayOfASCIIEncMessages[4],manualKeyGuess));



    }

    public static String createSplitStringArray(String inputString, String key){
        int kLength = key.length();
        int sLength = inputString.length();
        boolean exact = false;
        String[] splitStrings;
        String[] splitStringsDecoded;
        StringXORer xoRer = new StringXORer();
        StringBuilder sb = new StringBuilder();

        if(sLength%kLength == 0){
            splitStrings = new String[sLength/kLength];
            splitStringsDecoded = new String[sLength/kLength];
        } else {
            splitStrings = new String[(sLength/kLength) + 1];
            splitStringsDecoded = new String[(sLength/kLength) +1];

        }

        for(int i = 0; i < splitStrings.length; i++){
            if((i*kLength) + kLength -1 < inputString.length()){
                splitStrings[i] = inputString.substring(i*kLength,(i*kLength) + kLength);
            } else {
                splitStrings[i] = inputString.substring(i*kLength,inputString.length() -1);
            }

        }

        for(int j = 0; j < splitStringsDecoded.length; j++){

            splitStringsDecoded[j] = xoRer.encode(splitStrings[j],key);
        }

        for(String s : splitStringsDecoded){
            sb.append(s);
        }


        return sb.toString();
    }


    public static String[] hexToString(String[] hexStrings){
        StringXORer stringXORer = new StringXORer();
        String[] asciiiString = new String[hexStrings.length];

        for(int i = 0; i < hexStrings.length; i++){
            asciiiString[i] = stringXORer.convertHexToString(hexStrings[i]);
        }
        return asciiiString;
    }

    public static String hexToString(String hexString){
        StringXORer stringXORer = new StringXORer();
        return stringXORer.convertHexToString(hexString);
    }

    public static boolean isCharASCIIAlphabet(String s){

        return s.matches("[a-zA-Z]");
    }

    public static String generateSpaceString(String s){
        String retString = "";

        for(int i = 0; i < s.length(); i++){
            retString = retString + " ";
        }
        return retString;

    }

    public static void read(String [] c) throws FileNotFoundException {
        Scanner sc;
        String txt;
        int i=0;
        sc = new Scanner(new File("kody.txt"));
        while(sc.hasNext()) {
            txt = sc.nextLine();
            if(!txt.isEmpty() && !txt.startsWith("kryptogram"))  {
                String txtNoSpace = txt.replaceAll("\\s","");
                c[i]=txtNoSpace;
               // System.out.println(txtNoSpace);
                i++;
            }
        }
    }



}