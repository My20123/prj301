/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */
package dal;

import java.util.List;
import java.sql.*;
import model.Products;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

/**
 *
 * @author tra my
 */
public class ProductDAOTest {
    
    private ProductDAO productDAO;
    
    public ProductDAOTest() {
    }
    
    @Mock
    private Connection mockConnection;
    @Mock
    private PreparedStatement mockPreparedStatement;
    @Mock
    private ResultSet mockResultSet;
   
    @Before
    public void setUp() throws SQLException {
        MockitoAnnotations.openMocks(this);
        productDAO= new ProductDAO();
        
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
    }
    

   @Test
public void testGetAllProductsByCategories_Success() throws Exception {
    // Giả lập dữ liệu trả về từ ResultSet
    when(mockResultSet.next()).thenReturn(true, true, true, true, true, false); // 5 sản phẩm
    when(mockResultSet.getInt(1)).thenReturn(1, 2, 3, 4, 5);
    when(mockResultSet.getString(2)).thenReturn(
        "Giày Chạy Bộ Nữ Adidas Supernova Rise - Xanh Dương",
        "Giày Thể Thao Nam Adidas Ultraboost 1.0 - Đen",
        "Giày Chạy Bộ Nam Adidas Supernova Stride - Xanh Dương",
        "Giày Tập Luyện Nữ Adidas Dropset 3 Trainer - Be",
        "Giày Sneaker Nữ Adidas Grand Court 2.0 - Hồng"
    );
    when(mockResultSet.getString(3)).thenReturn(
        "https://supersports.com.vn/cdn/shop/files/ID3595-1.jpg?v=1726651554&width=1000",
        "https://supersports.com.vn/cdn/shop/files/HQ4199-1.jpg?v=1717755517&width=1000",
        "https://supersports.com.vn/cdn/shop/files/IG8311-1.jpg?v=1706783520&width=1000",
        "https://supersports.com.vn/cdn/shop/files/ID8635-1.jpg?v=1717755617&width=1000",
        "https://supersports.com.vn/cdn/shop/files/ID3004-1.jpg?v=1716869851&width=1000"
    );
    when(mockResultSet.getDouble(4)).thenReturn(3800000.0, 3600000.0, 2240000.0, 3150000.0, 1400000.0);
    when(mockResultSet.getString(5)).thenReturn(
        "GIÀY CHẠY BỘ NỮ ADIDAS SUPERNOVA RISE",
        "GIÀY THỂ THAO NAM ADIDAS ULTRABOOST 1.0",
        "GIÀY CHẠY BỘ NAM ADIDAS SUPERNOVA STRIDE",
        "GIÀY TẬP LUYỆN NỮ ADIDAS DROPSET 3 TRAINER",
        "GIÀY SNEAKER NỮ ADIDAS GRAND COURT 2.0"
    );
    when(mockResultSet.getString(6)).thenReturn(
        "Được Womens Health trao giải thưởng đôi giày chạy bộ...",
        "Khi đi dạo trong công viên cũng như chạy bộ cuối tuần...",
        "Đôi giày chạy bộ nam Adidas Supernova Stride chính là...",
        "Bất kể buổi tập của bạn đòi hỏi sức mạnh hay sức bền...",
        "Nhẹ nhàng lướt qua những ngày dài bận rộn..."
    );

    // Gọi phương thức cần test
    List<Products> result = productDAO.getAllProductsByCategories("1");

    // Kiểm tra kết quả
    assertNotNull(result);
    assertEquals(5, result.size());

    // Kiểm tra sản phẩm đầu tiên
    assertEquals(16, result.get(0).getId());
    assertEquals("Giày Chạy Bộ Nữ Adidas Supernova Rise - Xanh Dương", result.get(0).getName());
    assertEquals(3800000.0, result.get(0).getPrice(), 0.01);

    // Kiểm tra sản phẩm cuối cùng
    assertEquals(20, result.get(4).getId());
    assertEquals("Giày Sneaker Nữ Adidas Grand Court 2.0 - Hồng", result.get(4).getName());
    assertEquals(1400000.0, result.get(4).getPrice(), 0.01);
}

    
    @Test
    public void testGetAllProductsByCategories_EmptyResult() throws Exception {
        // Giả lập ResultSet không có dữ liệu
        when(mockResultSet.next()).thenReturn(false);

        List<Products> result = productDAO.getAllProductsByCategories("999");

        assertNotNull(result);
        assertEquals(0, result.size());
    }
    


@Test(expected = IllegalArgumentException.class)
public void testGetAllProductsByCategories_NullValue() throws Exception {
    productDAO.getAllProductsByCategories(null);
}

@Test(expected = IllegalArgumentException.class)
public void testGetAllProductsByCategories_NonNumericId() throws Exception {
    productDAO.getAllProductsByCategories("abc@");
}

}
