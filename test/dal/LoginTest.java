package dal;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.time.Duration;

public class LoginTest {
    private String baseUrl = "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/Login.jsp"; // Thay đổi URL này thành URL của ứng dụng của bạn

    @Test(priority = 1)
    public void testValidLogin_1() {
        System.setProperty("webdriver.chrome.driver", "D:\\SE\\kì 5\\SWT\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe"); // Thay đổi đường dẫn này thành đường dẫn tới chromedriver của bạn
        WebDriver driver = new ChromeDriver();
        driver.get(baseUrl);

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement usernameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("user")));
        WebElement passwordField = driver.findElement(By.name("pass"));
        WebElement loginButton = driver.findElement(By.cssSelector("button[type='submit']"));

        usernameField.sendKeys("Adam"); // Thay đổi thành username hợp lệ
        passwordField.sendKeys("1234"); // Thay đổi thành password hợp lệ
        loginButton.click();

        // Kiểm tra xem có chuyển hướng đến trang chủ hay không
        Assert.assertEquals(driver.getCurrentUrl(), "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/home");

        driver.quit();
    }

    @Test(priority = 2)
    public void testValidLogin_2() {
        System.setProperty("webdriver.chrome.driver", "D:\\SE\\kì 5\\SWT\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe"); // Thay đổi đường dẫn này thành đường dẫn tới chromedriver của bạn
        WebDriver driver = new ChromeDriver();
        driver.get(baseUrl);

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement usernameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("user")));
        WebElement passwordField = driver.findElement(By.name("pass"));
        WebElement loginButton = driver.findElement(By.cssSelector("button[type='submit']"));

        usernameField.sendKeys("Tuan"); // Thay đổi thành username hợp lệ
        passwordField.sendKeys("12345"); // Thay đổi thành password hợp lệ
        loginButton.click();

        // Kiểm tra xem có chuyển hướng đến trang chủ hay không
        Assert.assertEquals(driver.getCurrentUrl(), "http://localhost:9999/PROJECT_PRJ301_SHOPPIN/home");

        driver.quit();
    }

    @Test(priority = 3)
    public void testInvalidLogin_1() {
        System.setProperty("webdriver.chrome.driver", "D:\\SE\\kì 5\\SWT\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe"); // Thay đổi đường dẫn này thành đường dẫn tới chromedriver của bạn
        WebDriver driver = new ChromeDriver();
        driver.get(baseUrl);

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement usernameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("user")));
        WebElement passwordField = driver.findElement(By.name("pass"));
        WebElement loginButton = driver.findElement(By.cssSelector("button[type='submit']"));

        usernameField.sendKeys("Adam");
        passwordField.sendKeys("12345");
        loginButton.click();

        // Kiểm tra xem có hiển thị thông báo lỗi hay không
        WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("text-warning")));
        Assert.assertTrue(errorMessage.isDisplayed());
        Assert.assertEquals(errorMessage.getText(), "Wrong user or pass! Try again");

        driver.quit();
    }

    @Test(priority = 4)
    public void testInvalidLogin_2() {
        System.setProperty("webdriver.chrome.driver", "D:\\SE\\kì 5\\SWT\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe"); // Thay đổi đường dẫn này thành đường dẫn tới chromedriver của bạn
        WebDriver driver = new ChromeDriver();
        driver.get(baseUrl);

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        WebElement usernameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("user")));
        WebElement passwordField = driver.findElement(By.name("pass"));
        WebElement loginButton = driver.findElement(By.cssSelector("button[type='submit']"));

        usernameField.sendKeys("Kien");
        passwordField.sendKeys("123444");
        loginButton.click();

        // Kiểm tra xem có hiển thị thông báo lỗi hay không
        WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("text-warning")));
        Assert.assertTrue(errorMessage.isDisplayed());
        Assert.assertEquals(errorMessage.getText(), "Wrong user or pass! Try again");

        driver.quit();
    }
}