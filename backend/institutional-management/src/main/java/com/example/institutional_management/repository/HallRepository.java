package com.example.institutional_management.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.institutional_management.model.Hall;

@Repository
public interface HallRepository extends JpaRepository<Hall, Long> {
    // Add custom queries if needed
} 