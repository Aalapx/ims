package com.example.institutional_management.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.institutional_management.model.Hall;
import com.example.institutional_management.repository.HallRepository;
import java.util.List;

@RestController
@RequestMapping("/api/halls")
@CrossOrigin(origins = "*")
public class HallController {

    @Autowired
    private HallRepository hallRepository;

    @GetMapping
    public ResponseEntity<List<Hall>> getAllHalls() {
        List<Hall> halls = hallRepository.findAll();
        // Initialize amenities for each hall (due to LAZY loading)
        halls.forEach(hall -> hall.getAmenities().size()); // Force initialization
        return ResponseEntity.ok(halls);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getHallById(@PathVariable Long id) {
        return hallRepository.findById(id)
            .map(hall -> {
                hall.getAmenities().size(); // Force initialization
                return ResponseEntity.ok(hall);
            })
            .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<?> createHall(@RequestBody Hall hall) {
        try {
            Hall savedHall = hallRepository.save(hall);
            return ResponseEntity.ok(savedHall);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateHall(@PathVariable Long id, @RequestBody Hall hall) {
        try {
            if (!hallRepository.existsById(id)) {
                return ResponseEntity.notFound().build();
            }
            hall.setId(id);
            Hall updatedHall = hallRepository.save(hall);
            return ResponseEntity.ok(updatedHall);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteHall(@PathVariable Long id) {
        try {
            if (!hallRepository.existsById(id)) {
                return ResponseEntity.notFound().build();
            }
            hallRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
} 