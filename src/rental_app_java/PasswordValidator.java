package rental_app_java;

import java.util.regex.Pattern;

public class PasswordValidator {

    private static final int MIN_LENGTH = 8;
    private static final int MAX_LENGTH = 20;
    private static final String UPPER_CASE_REGEX = "(?=.*[A-Z])";
    private static final String LOWER_CASE_REGEX = "(?=.*[a-z])";
    private static final String DIGIT_REGEX = "(?=.*[0-9])";
    private static final String SPECIAL_CHAR_REGEX = "(?=.*[@#$%^&+=*])";
    private static final String COMMON_PATTERNS_REGEX = "^(?=.*(.)\\1{2,}).*$";
    private static final String PERSONAL_INFO_REGEX = "^(?=.*(?:password|username|email)).*$";


    public static boolean isValid(String password) {
        return isLengthValid(password) &&
                containsUpperCase(password) &&
                containsLowerCase(password) &&
                containsDigit(password) &&
                containsSpecialChar(password) &&
                !containsCommonPatterns(password) &&
                !containsPersonalInfo(password);
    }

    private static boolean isLengthValid(String password) {
        return password.length() >= MIN_LENGTH && password.length() <= MAX_LENGTH;
    }

    private static boolean containsUpperCase(String password) {
        return Pattern.compile(UPPER_CASE_REGEX).matcher(password).find();
    }

    private static boolean containsLowerCase(String password) {
        return Pattern.compile(LOWER_CASE_REGEX).matcher(password).find();
    }

    private static boolean containsDigit(String password) {
        return Pattern.compile(DIGIT_REGEX).matcher(password).find();
    }

    private static boolean containsSpecialChar(String password) {
        return Pattern.compile(SPECIAL_CHAR_REGEX).matcher(password).find();
    }

    private static boolean containsCommonPatterns(String password) {
        return Pattern.compile(COMMON_PATTERNS_REGEX).matcher(password).find();
    }

    private static boolean containsPersonalInfo(String password) {
        return Pattern.compile(PERSONAL_INFO_REGEX).matcher(password).find();
    }

//    public static void main(String[] args) {
//        String password = "Abc*12345";
//
//        System.out.println("Length valid: " + isLengthValid(password));
//        System.out.println("Contains uppercase: " + containsUpperCase(password));
//        System.out.println("Contains lowercase: " + containsLowerCase(password));
//        System.out.println("Contains digit: " + containsDigit(password));
//        System.out.println("Contains special char: " + containsSpecialChar(password));
//        System.out.println("Contains common patterns: " + containsCommonPatterns(password));
//        System.out.println("Contains personal info: " + containsPersonalInfo(password));
//
//        if (isValid(password)) {
//            System.out.println("Password is valid.");
//        } else {
//            System.out.println("Password is invalid.");
//        }
//    }
}
