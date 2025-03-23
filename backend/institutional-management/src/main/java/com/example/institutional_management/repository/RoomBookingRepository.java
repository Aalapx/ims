package com.example.institutional_management.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.institutional_management.model.RoomBooking;
import com.example.institutional_management.model.User;
import java.util.List;

@Repository
public interface RoomBookingRepository extends JpaRepository<RoomBooking, Long> {
    List<RoomBooking> findByUser(User user);
    List<RoomBooking> findByUserOrderByCreatedAtDesc(User user);
} 