package com.example.institutional_management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.institutional_management.model.HallBooking;
import com.example.institutional_management.model.User;
import com.example.institutional_management.model.Hall;
import com.example.institutional_management.repository.HallBookingRepository;
import com.example.institutional_management.repository.UserRepository;
import com.example.institutional_management.repository.HallRepository;
import java.util.List;

@RestController
@RequestMapping("/api/halls/bookings")
@CrossOrigin(origins = "*")
public class HallBookingController {

    @Autowired
    private HallBookingRepository hallBookingRepository;

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private HallRepository hallRepository;

    @PostMapping
    public ResponseEntity<?> createBooking(@RequestBody HallBooking booking) {
        try {
            User user = userRepository.findById(Long.parseLong(booking.getUserId()))
                .orElseThrow(() -> new RuntimeException("User not found"));
            
            Hall hall = hallRepository.findById(booking.getHallId())
                .orElseThrow(() -> new RuntimeException("Hall not found"));
                
            booking.setUser(user);
            booking.setHall(hall);
            booking.setStatus("PENDING");
            
            HallBooking savedBooking = hallBookingRepository.save(booking);
            return ResponseEntity.ok(savedBooking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getUserBookings(@PathVariable Long userId) {
        try {
            User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
            List<HallBooking> bookings = hallBookingRepository.findByUserOrderByCreatedAtDesc(user);
            return ResponseEntity.ok(bookings);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<?> updateBookingStatus(@PathVariable Long id, @RequestParam String status) {
        try {
            HallBooking booking = hallBookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
            booking.setStatus(status);
            HallBooking updatedBooking = hallBookingRepository.save(booking);
            return ResponseEntity.ok(updatedBooking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> cancelBooking(@PathVariable Long id) {
        try {
            HallBooking booking = hallBookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
            booking.setStatus("CANCELLED");
            HallBooking updatedBooking = hallBookingRepository.save(booking);
            return ResponseEntity.ok(updatedBooking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
} 