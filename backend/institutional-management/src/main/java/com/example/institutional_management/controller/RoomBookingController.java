package com.example.institutional_management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.institutional_management.model.RoomBooking;
import com.example.institutional_management.model.User;
import com.example.institutional_management.repository.RoomBookingRepository;
import com.example.institutional_management.repository.UserRepository;
import java.util.List;

@RestController
@RequestMapping("/api/room-bookings")
@CrossOrigin(origins = "*")
public class RoomBookingController {

    @Autowired
    private RoomBookingRepository roomBookingRepository;

    @Autowired
    private UserRepository userRepository;

    @PostMapping
    public ResponseEntity<?> createBooking(@RequestBody RoomBooking booking, @RequestParam String userEmail) {
        try {
            User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
            booking.setUser(user);
            booking.setStatus("PENDING");
            RoomBooking savedBooking = roomBookingRepository.save(booking);
            return ResponseEntity.ok(savedBooking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/user/{email}")
    public ResponseEntity<?> getUserBookings(@PathVariable String email) {
        try {
            User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));
            List<RoomBooking> bookings = roomBookingRepository.findByUserOrderByCreatedAtDesc(user);
            return ResponseEntity.ok(bookings);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<?> updateBookingStatus(@PathVariable Long id, @RequestParam String status) {
        try {
            RoomBooking booking = roomBookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
            booking.setStatus(status);
            RoomBooking updatedBooking = roomBookingRepository.save(booking);
            return ResponseEntity.ok(updatedBooking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> cancelBooking(@PathVariable Long id) {
        try {
            RoomBooking booking = roomBookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
            booking.setStatus("CANCELLED");
            RoomBooking updatedBooking = roomBookingRepository.save(booking);
            return ResponseEntity.ok(updatedBooking);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
} 