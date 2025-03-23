package com.example.institutional_management.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "hall_bookings")
public class HallBooking {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hall_id", nullable = false)
    private Hall hall;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Transient
    private String userId; // Used for request mapping
    
    @Transient
    private Long hallId; // Used for request mapping
    
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String purpose;
    private Integer expectedAttendees;
    private String specialRequirements;
    private String status; // PENDING, CONFIRMED, CANCELLED
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
} 