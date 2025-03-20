package dal;

import model.Products;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.sql.*;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class ProductDAOTest {

    @Mock
    private DBContext dbContext;

    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    private ResultSet resultSet;

    private ProductDAO productDAO; // Không dùng @InjectMocks vì cần truyền mock vào constructor

    @Before
    public void setUp() throws SQLException, Exception {
        // Giả lập hành vi của DBContext
        when(dbContext.getConnection()).thenReturn(connection);
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);

        productDAO = new ProductDAO(dbContext); // Inject mock DBContext vào ProductDAO
    }
//_____________________ Test Get Product by CategoryID _____________________________
    @Test
    public void getAllProductsByCategories_ValidCategoryId_ReturnsListOfProducts() throws SQLException, Exception {
        int categoryId = 1;

        // Giả lập dữ liệu ResultSet
        when(resultSet.next()).thenReturn(true, true,true,true,true, false); // Simulate 2 products
        when(resultSet.getInt(1)).thenReturn(16, 17,18,19,20);
        when(resultSet.getString(2)).thenReturn("Giày Chạy Bộ Nữ Adidas Supernova Rise - Xanh Dương", "Giày Thể Thao Nam Adidas Ultraboost 1.0 - Đen","Giày Chạy Bộ Nam Adidas Supernova Stride - Xanh Dương","Giày Tập Luyện Nữ Adidas Dropset 3 Trainer - Be","Giày Sneaker Nữ Adidas Grand Court 2.0 - Hồng");
        when(resultSet.getDouble(4)).thenReturn(3800000.00, 3600000.00,2240000.00,3150000.00,1400000.00);


        // Gọi hàm
        List<Products> products = productDAO.getAllProductsByCategories(categoryId);

        // Kiểm tra kết quả
        assertNotNull(products);
        assertEquals(5, products.size());
        assertEquals(16, products.get(0).getId());
        assertEquals("Giày Chạy Bộ Nữ Adidas Supernova Rise - Xanh Dương", products.get(0).getName());

        assertEquals(20, products.get(4).getId());
        assertEquals("Giày Sneaker Nữ Adidas Grand Court 2.0 - Hồng", products.get(4).getName());

        verify(preparedStatement).setInt(1, categoryId);
        verify(preparedStatement).executeQuery();
    }

    @Test
    public void getAllProductsByCategories_BelowMin_ReturnsEmptyList() throws SQLException, Exception {
        int categoryId=0;
        when(resultSet.next()).thenReturn(false); 

        List<Products> products = productDAO.getAllProductsByCategories(categoryId);

        assertNotNull(products);
        assertTrue(products.isEmpty());

        verify(preparedStatement).setInt(1, categoryId);
        verify(preparedStatement).executeQuery();
    }

    
    @Test
    public void getAllProductsByCategories_NegativeCategoryId_ThrowsIllegalArgumentException() {
        int categoryId = -1;

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            productDAO.getAllProductsByCategories(categoryId);
        });

        assertEquals("Category ID phải là số nguyên dương", exception.getMessage());
    }

    public void getAllProductsByCategories_MaxCategoryId_ReturnsListOfProducts() throws SQLException, Exception {
        int categoryId = 7;

        // Giả lập dữ liệu ResultSet
        when(resultSet.next()).thenReturn(true, true,true,true,true, false); // Simulate 2 products
        when(resultSet.getInt(1)).thenReturn(16, 17,18,19,20);
        when(resultSet.getString(2)).thenReturn("Giày Chạy Bộ Nữ Adidas Supernova Rise - Xanh Dương", "Giày Thể Thao Nam Adidas Ultraboost 1.0 - Đen","Giày Chạy Bộ Nam Adidas Supernova Stride - Xanh Dương","Giày Tập Luyện Nữ Adidas Dropset 3 Trainer - Be","Giày Sneaker Nữ Adidas Grand Court 2.0 - Hồng");
        when(resultSet.getDouble(4)).thenReturn(3800000.00, 3600000.00,2240000.00,3150000.00,1400000.00);


        // Gọi hàm
        List<Products> products = productDAO.getAllProductsByCategories(categoryId);

        // Kiểm tra kết quả
        assertNotNull(products);
        assertEquals(5, products.size());
        assertEquals(16, products.get(0).getId());
        assertEquals("Giày Chạy Bộ Nữ Adidas Supernova Rise - Xanh Dương", products.get(0).getName());

        assertEquals(20, products.get(4).getId());
        assertEquals("Giày Sneaker Nữ Adidas Grand Court 2.0 - Hồng", products.get(4).getName());

        verify(preparedStatement).setInt(1, categoryId);
        verify(preparedStatement).executeQuery();
    }
   
    @Test
public void getAllProductsByCategories_AboveMax_ReturnsEmptyList() throws SQLException, Exception {
    int categoryId = 8; 

    when(resultSet.next()).thenReturn(false);

    List<Products> products = productDAO.getAllProductsByCategories(categoryId);

    assertNotNull(products);
    assertTrue(products.isEmpty());

    verify(preparedStatement).setInt(1, categoryId);
    verify(preparedStatement).executeQuery();
}

//_____________________ Test Delete _____________________________
  @Test
    public void deleteProduct_ValidId_Success() throws SQLException {
        int validProductId = 1;

        // Gọi hàm cần test
        productDAO.deleteProduct(validProductId);

        // Kiểm tra xem phương thức setInt() và executeUpdate() có được gọi không
        verify(preparedStatement).setInt(1, validProductId);
        verify(preparedStatement).executeUpdate();
    }
    
@Test
    public void deleteProduct_NegativeId_ThrowsException() {
        int negativeProductId = -5;

        try {
            productDAO.deleteProduct(negativeProductId);
            fail("Expected IllegalArgumentException but none was thrown");
        } catch (IllegalArgumentException e) {
            assertEquals("Product ID phải là số nguyên dương", e.getMessage());
        }
    }
    
   @Test
    public void deleteProduct_ZeroId_NoEffect() throws SQLException {
        int zeroProductId = 0;
        when(preparedStatement.executeUpdate()).thenReturn(0);

        productDAO.deleteProduct(zeroProductId);

        verify(preparedStatement).setInt(1, zeroProductId);
        verify(preparedStatement).executeUpdate();
    }
    
        @Test
    public void deleteProduct_MaxId_Success() throws SQLException {
        int maxProductId = 60;

        productDAO.deleteProduct(maxProductId);

        verify(preparedStatement).setInt(1, maxProductId);
        verify(preparedStatement).executeUpdate();
    }
    @Test
    public void deleteProduct_AboveMax_NoEffect() throws SQLException {
        int aboveMaxProductId = 61;
        when(preparedStatement.executeUpdate()).thenReturn(0);

        productDAO.deleteProduct(aboveMaxProductId);

        verify(preparedStatement).setInt(1, aboveMaxProductId);
        verify(preparedStatement).executeUpdate();
    }
    //_____________________ Test Insert _____________________________
    @Test
    public void insertProduct_NegativeNumber_ThrowsIllegalArgumentException(){
        double price = -1;
        int category=-2,sid=-3;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            productDAO.insertProduct(name, image, price, title, description, category, sid);
        });

        assertEquals("Số phải là số nguyên dương", exception.getMessage());
    }
    
    @Test
    public void insertProduct_EmptyOrNullString_ThrowsIllegalArgumentException(){
        double price = 0;
        int category=1,sid=1;
        
        String name=null, image="",title="" ,description=null;

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            productDAO.insertProduct(name, image, price, title, description, category, sid);
        });

        assertEquals("Các giá trị chuỗi không được để trống", exception.getMessage());
    }
    
     @Test
    public void insertProduct_BelowMinOfForeignKey_NoEffect() throws Exception {
        double price = 1;
        int category=0,sid=0;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";

        when(preparedStatement.executeUpdate()).thenReturn(0);
        
        productDAO.insertProduct(name, image, price, title, description, category, sid);
        verify(preparedStatement).executeUpdate();
    }
    
     @Test
    public void insertProduct_AboveMaxOfForeignKeys_NoEffect() throws Exception {
        double price = 1;
        int category=8,sid=7;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";

        when(preparedStatement.executeUpdate()).thenReturn(0);
        
        productDAO.insertProduct(name, image, price, title, description, category, sid);
        verify(preparedStatement).executeUpdate();
    }
    
     @Test
    public void insertProduct_MinOfForeignKeys_Success() throws Exception {
        double price = 1;
        int category=1,sid=1;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";
        
        productDAO.insertProduct(name, image, price, title, description, category, sid);
        
        verify(preparedStatement,times(1)).executeUpdate();
    }
    
    @Test
    public void insertProduct_MaxOfForeignKeys_Success() throws Exception {
        double price = 1;
        int category=7,sid=6;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";
        
        productDAO.insertProduct(name, image, price, title, description, category, sid);
        
        verify(preparedStatement,times(1)).executeUpdate();
    }
    
    
    //_____________________ Test Update _____________________________
    @Test
    public void updateProduct_NegativeNumber_ThrowsIllegalArgumentException(){
        double price = -1;
        int id=-5,category=-2,sid=-3;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            productDAO.updateProduct(id, name, image, price, title, description, category, sid);
        });

        assertEquals("Số phải là số nguyên dương", exception.getMessage());
    }
    
    @Test
    public void updateProduct_EmptyOrNullString_ThrowsIllegalArgumentException(){
        double price = 0;
        int id=1, category=1,sid=1;
        
        String name=null, image="",title="" ,description=null;

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            productDAO.updateProduct(id, name, image, price, title, description, category, sid);
        });

        assertEquals("Các giá trị chuỗi không được để trống", exception.getMessage());
    }
    
     @Test
    public void updateProduct_BelowMinOfForeignKey_NoEffect() throws Exception {
        double price = 1;
        int id=1,category=0,sid=0;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";

        when(preparedStatement.executeUpdate()).thenReturn(0);
        
        productDAO.updateProduct(id, name, image, price, title, description, category, sid);
        verify(preparedStatement).executeUpdate();
    }
    
     @Test
    public void updateProduct_AboveMaxOfForeignKeys_NoEffect() throws Exception {
        double price = 1;
        int id=1, category=8,sid=7;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";

        when(preparedStatement.executeUpdate()).thenReturn(0);
        
        productDAO.updateProduct(id, name, image, price, title, description, category, sid);
        verify(preparedStatement).executeUpdate();
    }
    
    @Test
    public void updateProduct_BelowMinProductID_NoEffect() throws Exception {
        double price = 1;
        int id = 0, category = 1, sid = 1; 
        String name = "Giày Thượng Đình", image = "abc", title = "Giày Thượng Đình mới nhất", description = "Giày chạy êm, phù hợp với tinh thần thể thao";

        when(preparedStatement.executeUpdate()).thenReturn(0);

        productDAO.updateProduct(id, name, image, price, title, description, category, sid);

        verify(preparedStatement, times(1)).executeUpdate();
    }
    
    @Test
    public void updateProduct_AboveMaxProductID_NoEffect() throws Exception {
        double price = 1;
        int id = 60, category = 7, sid = 6; 
        String name = "Giày Thượng Đình", image = "abc", title = "Giày Thượng Đình mới nhất", description = "Giày chạy êm, phù hợp với tinh thần thể thao";

        when(preparedStatement.executeUpdate()).thenReturn(0);

        productDAO.updateProduct(id, name, image, price, title, description, category, sid);

        verify(preparedStatement, times(1)).executeUpdate();
    }
    
     @Test
    public void updateProduct_MinOfForeignKeys_MinOfProductID_Success() throws Exception {
        double price = 1;
        int id=1, category=7,sid=6;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";
        
        productDAO.updateProduct(id, name, image, price, title, description, category, sid);
        
        verify(preparedStatement,times(1)).executeUpdate();
    }
    
    @Test
    public void updateProduct_MaxOfForeignKeys_MaxOfProductID_Success() throws Exception {
        double price = 1;
        int id=60,category=1,sid=1;
        
        String name="Giày Thượng Đình", image="abc",title="Giày Thượng Đình mới nhất" ,description="Giày chạy êm, phù hợp với tinh thần thể thao";
        
        productDAO.updateProduct(id, name, image, price, title, description, category, sid);
        
        verify(preparedStatement,times(1)).executeUpdate();
    }
}
