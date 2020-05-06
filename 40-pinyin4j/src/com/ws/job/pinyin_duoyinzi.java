package com.ws.job;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.util.HashSet;
import java.util.Set;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

/**
 * Created by lenovo on 15/11/12. 多音字全部显示，中间以逗号隔开。
 */
public class pinyin_duoyinzi {
    /**
     * 字符串集合转换字符串(逗号分隔)
     * 
     * @author wyh
     * @param stringSet
     * @return
     */
    public static String makeStringByStringSet(Set<String> stringSet) {
        StringBuilder str = new StringBuilder();
        int i = 0;
        for (String s : stringSet) {
            if (i == stringSet.size() - 1) {
                str.append(s);
            } else {
                str.append(s + ",");
                // str.append("\n");
            }
            i++;
        }
        return str.toString().toLowerCase();
    }

    /**
     * 获取拼音集合
     * 
     * @author wyh
     * @param src
     * @return Set<String>
     */
    public static Set<String> getPinyin(String src) {
        if (src != null && !src.trim().equalsIgnoreCase("")) {
            char[] srcChar;
            srcChar = src.toCharArray();
            // 汉语拼音格式输出类
            HanyuPinyinOutputFormat hanYuPinOutputFormat = new HanyuPinyinOutputFormat();

            // 输出设置，大小写，音标方式等
            hanYuPinOutputFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
            hanYuPinOutputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
            hanYuPinOutputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);

            String[][] temp = new String[src.length()][];
            for (int i = 0; i < srcChar.length; i++) {
                char c = srcChar[i];
                // 是中文或者a-z或者A-Z转换拼音(我的需求，是保留中文或者a-z或者A-Z)
                if (String.valueOf(c).matches("[\\u4E00-\\u9FA5]+")) {
                    try {
                        temp[i] = PinyinHelper.toHanyuPinyinStringArray(srcChar[i], hanYuPinOutputFormat);
                    } catch (BadHanyuPinyinOutputFormatCombination e) {
                        e.printStackTrace();
                    }
                } else if (((int) c >= 65 && (int) c <= 90) || ((int) c >= 97 && (int) c <= 122)) {
                    temp[i] = new String[] { String.valueOf(srcChar[i]) };
                } else {
                    temp[i] = new String[] { "" };
                }
            }
            String[] pingyinArray = Exchange(temp);
            Set<String> pinyinSet = new HashSet<>();
            for (int i = 0; i < pingyinArray.length; i++) {
                pinyinSet.add(pingyinArray[i]);
            }
            return pinyinSet;
        }
        return null;
    }

    /**
     * 递归
     * 
     * @author wyh
     * @param strJaggedArray
     * @return
     */
    public static String[] Exchange(String[][] strJaggedArray) {
        String[][] temp = DoExchange(strJaggedArray);
        return temp[0];
    }

    /**
     * 递归
     * 
     * @author wyh
     * @param strJaggedArray
     * @return
     */
    private static String[][] DoExchange(String[][] strJaggedArray) {
        int len = strJaggedArray.length;
        if (len >= 2) {
            int len1 = strJaggedArray[0].length;
            int len2 = strJaggedArray[1].length;
            int newlen = len1 * len2;
            String[] temp = new String[newlen];
            int Index = 0;
            for (int i = 0; i < len1; i++) {
                for (int j = 0; j < len2; j++) {
                    // temp[Index] = strJaggedArray[0][i] + strJaggedArray[1][j];
                    // by hsw : 返回拼音之间增加一个空格
                    temp[Index] = strJaggedArray[0][i] + " " + strJaggedArray[1][j];
                    // by hsw : 去除多余空格
                    temp[Index] = temp[Index].trim();

                    Index++;
                }
            }
            String[][] newArray = new String[len - 1][];
            for (int i = 2; i < len; i++) {
                newArray[i - 1] = strJaggedArray[i];
            }
            newArray[0] = temp;
            return DoExchange(newArray);
        } else {
            return strJaggedArray;
        }
    }

    /**
     * @param args
     */
    // public static void main(String[] args) {
    // String str = "单田芳";
    // System.out.println(makeStringByStringSet(getPinyin(str)));
    //
    // }
    /**
     * 功能：Java读取txt文件的内容 步骤：1：先获得文件句柄 2：获得文件句柄当做是输入一个字节码流，需要对这个输入流进行读取
     * 3：读取到输入流后，需要读取生成字节流 4：一行一行的输出。readline()。 备注：需要考虑的是异常情况
     * 
     * @param filePath
     */
    public static void readTxtFile(String filePath) {
        try {
            StringBuilder sb = new StringBuilder();
            // String encoding="GBK";
            String encoding = "UTF-8";
            File file = new File(filePath);
            if (file.isFile() && file.exists()) { // 判断文件是否存在
                InputStreamReader read = new InputStreamReader(new FileInputStream(file), encoding);// 考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                while ((lineTxt = bufferedReader.readLine()) != null) {
                    // System.out.println(lineTxt+" "+converterToSpell(lineTxt));
                    // System.out.println(makeStringByStringSet(getPinyin(lineTxt)));
                    // System.out.println(getPinyin(lineTxt));
                    // by hsw : 根据我的要求调整输出格式
                    String[] listPinyin = makeStringByStringSet(getPinyin(lineTxt)).split(",");
                    for (String itemPingyin : listPinyin) {
                        // System.out.println(lineTxt + "\t" + itemPingyin);
                        sb.append(lineTxt + "\t" + itemPingyin + "\t1000\n");
                    }
                }
                read.close();

                // 如果输出有内容，将内容输出到文件中
                if (sb.length() > 0) {
                    // File fileOutput = new File(file.get+file.getName());
                    FileWriter fileWritter = new FileWriter(filePath+".out", true);
                    BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
                    bufferWritter.write(sb.toString());
                    bufferWritter.close();
                }
            } else {
                System.out.println("找不到指定的文件");
            }
        } catch (Exception e) {
            System.out.println("读取文件内容出错");
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        String filePath = "R:\\1.txt";
        // "res/";
        readTxtFile(filePath);
    }
}
