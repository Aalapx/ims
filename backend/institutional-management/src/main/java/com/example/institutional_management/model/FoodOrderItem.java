package com.example.institutional_management.model;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class FoodOrderItem {
    private String itemName;
    private Integer quantity;
    private Double unitPrice;
    private String specialRequests;
} 