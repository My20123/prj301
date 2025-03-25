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
import java.time.Duration;

public class addAccountTest {

    private WebDriver driver;
    private Connection connection;

    @BeforeClass
    public void setUp() throws Exception {
        // Thiết lập Selenium WebDriver
        System.setProperty("webdriver.chrome.driver", "D:\\SE\\kì 5\\SWT\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");
        driver = new ChromeDriver();

        // Kết nối cơ sở dữ liệu
        DBContext dbContext = new DBContext();
        connection = dbContext.getConnection();
        connection.setAutoCommit(false); // Bật chế độ rollback
    }

    @BeforeMethod
    public void navigateToAddAccountPage() {
        // Điều hướng đến trang quản lý tài khoản
        driver.get("http://localhost:9999/PROJECT_PRJ301_SHOPPIN/viewA");
    }

    private void fillAndSubmitForm(String name, String email, String role, String phone) throws InterruptedException {
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

        nameField.clear();
        nameField.sendKeys(name);
        Thread.sleep(500);

        emailField.clear();
        emailField.sendKeys(email);
        Thread.sleep(500);

        Select roleDropdown = new Select(modal.findElement(By.name("role")));
        roleDropdown.selectByVisibleText(role);
        Thread.sleep(500);

        phoneField.clear();
        phoneField.sendKeys(phone);
        Thread.sleep(500);

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
    public void testValidAccount() throws InterruptedException {
        fillAndSubmitForm("Hoang", "hoang@gmail.com", "User", "0988765342");
        handleAlert(); // Xử lý hộp thoại thông báo
        Assert.assertEquals(driver.getCurrentUrl(), "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/viewA");
    }
    @Test(priority = 2)
    public void testBoundaryMin() throws InterruptedException {
        fillAndSubmitForm("H", "h@gmail.com", "User", "0988765342");
        handleAlert(); 
        Assert.assertEquals(driver.getCurrentUrl(), "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/viewA");
    }

    @Test(priority = 3)
    public void testBoundaryMax() throws InterruptedException {
        fillAndSubmitForm("Usernamertjkhjfghfjduhhhhhhhhh", "hoangkknwheuirieo123@gmail.com", "User", "0988765342");
        handleAlert(); 
        Assert.assertEquals(driver.getCurrentUrl(), "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/viewA");
    }

    @Test(priority = 4)
    public void testInvalidEmailFormat() throws InterruptedException {
        fillAndSubmitForm("Hoang", "hoang", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Email phai dung dinh dang @gmail.com");
    }

    @Test(priority = 5)
    public void testInvalidPhoneShort() throws InterruptedException {
        fillAndSubmitForm("Hoang", "hoang@gmail.com", "User", "09887");
        Assert.assertEquals(getErrorMessage(), "So dien thoai phai du 10 ky tu va khong chua ky tu dac biet hay chu cai");
    }

    @Test(priority = 6)
    public void testInvalidPhoneSpecialChars() throws InterruptedException {
        fillAndSubmitForm("Hoang", "hoang@gmail.com", "User", "0988765342abc@");
        Assert.assertEquals(getErrorMessage(), "So dien thoai phai du 10 ky tu va khong chua ky tu dac biet hay chu cai");
    }

    @Test(priority = 7)
    public void testEmptyEmail() throws InterruptedException {
        fillAndSubmitForm("Hoang", "", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Email khong duoc de trong");
    }

    @Test(priority = 8)
    public void testEmptyPhone() throws InterruptedException {
        fillAndSubmitForm("Hoang", "hoang@gmail.com", "User", "");
        Assert.assertEquals(getErrorMessage(), "So dien thoai khong duoc de trong");
    }

    @Test(priority = 9)
    public void testEmptyName() throws InterruptedException {
        fillAndSubmitForm("", "hoang@gmail.com", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Ten khong duoc de trong");
    }

    @Test(priority = 10)
    public void testNameTooLong() throws InterruptedException {
        fillAndSubmitForm("okkkkiuytertyturieorerergggggggg", "hoang@gmail.com", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Ten nguoi dung khong duoc vuot qua 30 ky tu");
    }

    @Test(priority = 11)
    public void testNameWithSpecialChars() throws InterruptedException {
        fillAndSubmitForm("okkkkiuytert11@", "hoang@gmail.com", "User", "0988765342");
        Assert.assertEquals(getErrorMessage(), "Ten nguoi dung khong duoc chua ky tu dac biet");
    }
    


    @AfterMethod
    public void rollbackDatabase() throws Exception {
        // Rollback các thay đổi trong cơ sở dữ liệu
        connection.rollback();
    }

    @AfterClass
    public void tearDown() throws Exception {
        // Đóng trình duyệt và kết nối cơ sở dữ liệu
        driver.quit();
        connection.close();
    }
}