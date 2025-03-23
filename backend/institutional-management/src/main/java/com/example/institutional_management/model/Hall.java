package com.example.institutional_management.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "halls")
public class Hall {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    private String description;
    private int capacity;
    private double pricePerHour;
    private String imageUrl;
    
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(
        name = "hall_amenities",
        joinColumns = @JoinColumn(name = "hall_id")
    )
    @Column(name = "amenity")
    private List<String> amenities = new ArrayList<>();
    
    @Column(name = "is_available")
    private boolean available = true;
    
    public List<String> getAmenities() {
        return amenities != null ? amenities : new ArrayList<>();
    }
    
    public void setAmenities(List<String> amenities) {
        this.amenities = amenities != null ? amenities : new ArrayList<>();
    }
} 