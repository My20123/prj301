package dal;

import dal.DBContext;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.sql.Connection;
import java.sql.Savepoint;
import java.sql.Statement;
import java.time.Duration;

public class addAccountTest {

    private WebDriver driver;
    private Connection connection;
    private Savepoint savepoint;

    @BeforeClass
    public void setUp() throws Exception {
        // Thiết lập Selenium WebDriver
        System.setProperty("webdriver.chrome.driver", "D:\\SE\\kì 5\\SWT\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");
        driver = new ChromeDriver();

        // Kết nối cơ sở dữ liệu
        DBContext dbContext = new DBContext();
        connection = dbContext.getConnection();
        connection.setAutoCommit(false); // Tắt auto-commit để hỗ trợ rollback
    }

    @BeforeMethod
    public void navigateToAddAccountPage() throws Exception {
        // Đặt Savepoint trước khi thực hiện test
        savepoint = connection.setSavepoint();

        // Điều hướng đến trang quản lý tài khoản
        driver.get("http://localhost:9999/PROJECT_PRJ301_SHOPPIN/viewA");
    }

    private void fillAndSubmitForm(String name, String email, String role, String phone) {
        // Nhấn vào nút "Add New Account"
        WebElement addNewAccountButton = driver.findElement(By.cssSelector("a.btn.btn-success"));
        addNewAccountButton.click();

        // Chờ modal hiển thị
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement modal = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("addEmployeeModal")));

        // Điền thông tin tài khoản
        WebElement nameField = modal.findElement(By.name("name"));
        WebElement emailField = modal.findElement(By.name("email"));
        WebElement phoneField = modal.findElement(By.name("phone"));
        WebElement submitButton = modal.findElement(By.cssSelector("input[type='submit']"));

        // Điền dữ liệu vào các trường
        nameField.clear();
        nameField.sendKeys(name);

        emailField.clear();
        emailField.sendKeys(email);

        Select roleDropdown = new Select(modal.findElement(By.name("role")));
        roleDropdown.selectByVisibleText(role);

        phoneField.clear();
        phoneField.sendKeys(phone);

        // Nhấn nút Submit
        submitButton.click();
    }

    private void handleAlert() {
        // Chờ hộp thoại thông báo xuất hiện
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        Alert alert = wait.until(ExpectedConditions.alertIsPresent());

        // Lấy nội dung của hộp thoại thông báo
        String alertText = alert.getText();
        System.out.println("Alert message: " + alertText);

        // Bấm nút "OK" trên hộp thoại
        alert.accept();
    }

    private String getErrorMessage() {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10)); // Tăng thời gian chờ
        WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessage"))); // Đúng ID từ JSP
        return errorMessage.getText();
    }

    @Test(priority = 1)
    public void testValidAccount() {
        fillAndSubmitForm("Hoang", "hoang@gmail.com", "User", "0988765342");
        handleAlert(); // Xử lý hộp thoại thông báo
        Assert.assertEquals(driver.getCurrentUrl(), "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/viewA");
    }

    @Test(priority = 2)
    public void testBoundaryMin() {
        fillAndSubmitForm("H", "h@gmail.com", "User", "0988765342");
        handleAlert();
        Assert.assertEquals(driver.getCurrentUrl(), "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/viewA");
    }

    @Test(priority = 3)
    public void testBoundaryMax() {
        fillAndSubmitForm("Usernamertjkhjfghfjduhhhhhhhhh", "hoangkknwheuirieo123@gmail.com", "User", "0988765342");
        handleAlert();
        Assert.assertEquals(driver.getCurrentUrl(), "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/viewA");
    }

    @Test(priority = 4)
    public void testInvalidEmailFormat() {
        fillAndSubmitForm("Hoang", "hoang", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Email phai dung dinh dang @gmail.com");
    }

    @Test(priority = 5)
    public void testInvalidPhoneShort() {
        fillAndSubmitForm("Hoang", "hoang@gmail.com", "User", "09887");
        Assert.assertEquals(getErrorMessage(), "So dien thoai phai du 10 ky tu va khong chua ky tu dac biet hay chu cai");
    }

    @Test(priority = 6)
    public void testInvalidPhoneSpecialChars() {
        fillAndSubmitForm("Hoang", "hoang@gmail.com", "User", "0988765342abc@");
        Assert.assertEquals(getErrorMessage(), "So dien thoai phai du 10 ky tu va khong chua ky tu dac biet hay chu cai");
    }

    @Test(priority = 7)
    public void testEmptyEmail() {
        fillAndSubmitForm("Hoang", "", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Email khong duoc de trong");
    }

    @Test(priority = 8)
    public void testEmptyPhone() {
        fillAndSubmitForm("Hoang", "hoang@gmail.com", "User", "");
        Assert.assertEquals(getErrorMessage(), "So dien thoai khong duoc de trong");
    }

    @Test(priority = 9)
    public void testEmptyName() {
        fillAndSubmitForm("", "hoang@gmail.com", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Ten khong duoc de trong");
    }

    @Test(priority = 10)
    public void testNameTooLong() {
        fillAndSubmitForm("okkkkiuytertyturieorerergggggggg", "hoang@gmail.com", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Ten nguoi dung khong duoc vuot qua 30 ky tu");
    }

    @Test(priority = 11)
    public void testNameWithSpecialChars() {
        fillAndSubmitForm("okkkkiuytert11@", "hoang@gmail.com", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Ten nguoi dung khong duoc chua ky tu dac biet");
    }

    @AfterMethod
    public void rollbackDatabase() throws Exception {
        if (connection != null && savepoint != null) {
            // Rollback về Savepoint
            connection.rollback(savepoint);
            System.out.println("Rollback về trạng thái trước khi test thành công!");
        }
    }

    @AfterClass
    public void tearDown() throws Exception {
        // Đóng trình duyệt và kết nối cơ sở dữ liệu
        driver.quit();
        if (connection != null) {
            connection.close();
        }
    }
}