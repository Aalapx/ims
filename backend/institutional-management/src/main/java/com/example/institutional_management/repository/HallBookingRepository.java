package com.example.institutional_management.repository;

import com.example.institutional_management.model.HallBooking;
import com.example.institutional_management.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface HallBookingRepository extends JpaRepository<HallBooking, Long> {
    List<HallBooking> findByUserOrderByCreatedAtDesc(User user);
} 