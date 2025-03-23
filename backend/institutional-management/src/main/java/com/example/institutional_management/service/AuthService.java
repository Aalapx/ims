package com.example.institutional_management.service;

import com.example.institutional_management.model.AuthRequest;
import com.example.institutional_management.model.AuthResponse;
import com.example.institutional_management.model.RegisterRequest;

public interface AuthService {
    AuthResponse login(AuthRequest request);
    AuthResponse register(RegisterRequest request);
}
