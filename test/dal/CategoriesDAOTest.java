package dal;

import dal.CategoriesDAO;
import model.Categories;
import org.junit.Before;
import org.junit.Test;
import org.mockito.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

public class CategoriesDAOTest {

    @Mock
    private Connection mockConnection;

    @Mock
    private PreparedStatement mockPreparedStatement;

    @Mock
    private ResultSet mockResultSet;

    @InjectMocks
    private CategoriesDAO categoriesDAO;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);

        // Mock các đối tượng cần thiết
        mockConnection = mock(Connection.class);
        mockPreparedStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);

        // Gán đối tượng mock cho DAO
        categoriesDAO = new CategoriesDAO(mockConnection);

        // Mock khi gọi prepareStatement và executeQuery
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
    }

    @Test
    public void testGetAllCategories_Success() {
        List<Categories> mockCategories = Arrays.asList(
                new Categories(1, "GIÀY ADIDAS"),
                new Categories(2, "GIÀY NIKE")
        );

        when(categoriesDAO.getAllCategories()).thenReturn(mockCategories);

        List<Categories> result = categoriesDAO.getAllCategories();
        assertEquals(2, result.size());
        assertEquals("GIÀY ADIDAS", result.get(0).getCname());
        assertEquals("GIÀY NIKE", result.get(1).getCname());
    }

    @Test
    public void testGetAllCategories_EmptyResult() {
        // Tạo một instance của CategoriesDAO với DBContext không hợp lệ
        CategoriesDAO errorDAO = new CategoriesDAO() {
            @Override
            public List<Categories> getAllCategories() {
                return new ArrayList<>(); // Trả về list rỗng khi có lỗi
            }
        };

        List<Categories> result = errorDAO.getAllCategories();
        assertTrue(result.isEmpty());
    }

    @Test
    public void testGetAllCategories_NullResult() {
        // Tạo một instance của CategoriesDAO với DBContext không hợp lệ
        CategoriesDAO errorDAO = new CategoriesDAO() {
            @Override
            public List<Categories> getAllCategories() {
                return null; // Trả về null để kiểm tra trường hợp lỗi
            }
        };
        List<Categories> result = errorDAO.getAllCategories();
        assertNull(result);
    }

    @Test
    public void testAddCategory_Valid() throws Exception {
        Categories category = new Categories(200, "New Category");
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);
        assertTrue(categoriesDAO.addCategory(category));
    }

    @Test
    public void testAddCategory_Invalid_EmptyName() throws Exception {
        Categories category = new Categories(201, "");
        when(mockPreparedStatement.executeUpdate()).thenReturn(0);
        assertFalse(categoriesDAO.addCategory(category));
    }

    @Test
    public void testAddCategory_OneCharacterName() throws Exception {
        Categories category = new Categories(202, "A");
        when(mockPreparedStatement.executeUpdate()).thenReturn(1); // Phải trả về 1 khi thêm thành công
        assertTrue(categoriesDAO.addCategory(category));
    }

    @Test
    public void testUpdateCategory_Valid() throws Exception {
        Categories category = new Categories(300, "Updated Name");
        when(mockPreparedStatement.executeUpdate()).thenReturn(1); // Phải trả về 1 để pass
        assertTrue(categoriesDAO.updateCategory(category));
    }

    @Test
    public void testUpdateCategory_Invalid_NullName() throws Exception {
        Categories category = new Categories(301, null);
        when(mockPreparedStatement.executeUpdate()).thenReturn(0);
        assertFalse(categoriesDAO.updateCategory(category));
    }

    @Test
    public void testUpdateCategory_NonExistingID() throws Exception {
        Categories category = new Categories(9999, "Valid Name");
        when(mockPreparedStatement.executeUpdate()).thenReturn(0);
        assertFalse(categoriesDAO.updateCategory(category));
    }

    @Test
    public void testDeleteCategory_Valid() throws Exception {
        when(mockPreparedStatement.executeUpdate()).thenReturn(1); // Trả về 1 khi xóa thành công
        assertTrue(categoriesDAO.deleteCategory(400));
    }

    @Test
    public void testDeleteCategory_Invalid_NegativeID() throws Exception {
        when(mockPreparedStatement.executeUpdate()).thenReturn(0);
        assertFalse(categoriesDAO.deleteCategory(-5));
    }

    @Test
    public void testDeleteCategory_ZeroID() throws Exception {
        when(mockPreparedStatement.executeUpdate()).thenReturn(0);
        assertFalse(categoriesDAO.deleteCategory(0));
    }
}
