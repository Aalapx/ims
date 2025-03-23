package com.example.institutional_management.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.institutional_management.model.FoodOrder;
import com.example.institutional_management.model.User;
import java.util.List;

@Repository
public interface FoodOrderRepository extends JpaRepository<FoodOrder, Long> {
    List<FoodOrder> findByUser(User user);
    List<FoodOrder> findByUserOrderByCreatedAtDesc(User user);
} 