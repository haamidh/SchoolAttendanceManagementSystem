package app.classes.dao;

import app.classes.model.Batch;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BatchDAO {

    public List<Batch> getAllBatches() {
        List<Batch> batches = new ArrayList<>();
        String query = "SELECT * FROM batches";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Batch batch = new Batch();
                batch.setBatchId(rs.getString("batch_id"));
                batch.setBatchName(rs.getString("batch_name"));
                batch.setYear(rs.getInt("year")); // Retrieve year
                batches.add(batch);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return batches;
    }

    public void addBatch(Batch batch) {
        String query = "INSERT INTO batches (batch_id, batch_name, year) VALUES (?, ?, ?)";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, batch.getBatchId());
            stmt.setString(2, batch.getBatchName());
            stmt.setInt(3, batch.getYear()); // Insert year
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteBatch(String batchId) {
        String query = "DELETE FROM batches WHERE batch_id = ?";

        try (Connection conn = DbConnector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, batchId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
