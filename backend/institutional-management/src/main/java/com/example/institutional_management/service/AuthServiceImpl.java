package com.example.institutional_management.service;

import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.institutional_management.config.JwtUtil;
import com.example.institutional_management.model.AuthRequest;
import com.example.institutional_management.model.AuthResponse;
import com.example.institutional_management.model.RegisterRequest;
import com.example.institutional_management.model.User;
import com.example.institutional_management.repository.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

    private static final Logger logger = LoggerFactory.getLogger(AuthServiceImpl.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    public AuthResponse login(AuthRequest request) {
        logger.debug("Attempting login for email: {}", request.getEmail());
        
        // TEMPORARY TEST CASE: Allow a hardcoded test user to log in for testing purposes
        if ("test@example.com".equals(request.getEmail()) && "password".equals(request.getPassword())) {
            logger.debug("Using test account with plain password");
            
            // Create a test user or fetch from database
            Optional<User> optionalUser = userRepository.findByEmail(request.getEmail());
            User user;
            
            if (optionalUser.isPresent()) {
                user = optionalUser.get();
                logger.debug("Test user found in database: {}", user);
            } else {
                // Create a test user only if it doesn't exist
                user = new User();
                user.setId(1L);
                user.setName("Test User");
                user.setEmail("test@example.com");
                user.setPassword(passwordEncoder.encode("password")); // Hash the password
                user.setRole("ADMIN");
                user = userRepository.save(user); // Save the user to database
                logger.debug("Created and saved test user: {}", user);
            }
            
            String token = jwtUtil.generateToken(user.getEmail());
            logger.debug("Generated token for test user");
            
            return new AuthResponse(
                    user.getId(),
                    user.getName(),
                    user.getEmail(),
                    user.getRole(),
                    token
            );
        }
        
        // Normal authentication flow
        logger.debug("Proceeding with normal authentication");
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("User not found with email: " + request.getEmail()));

        logger.debug("User found: {}", user);
        
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            logger.error("Password doesn't match for user: {}", request.getEmail());
            throw new RuntimeException("Invalid credentials - password doesn't match");
        }

        String token = jwtUtil.generateToken(user.getEmail());
        logger.debug("Authentication successful, token generated");

        return new AuthResponse(
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.getRole(),
                token
        );
    }

    @Override
    public AuthResponse register(RegisterRequest request) {
        logger.debug("Attempting registration for email: {}", request.getEmail());

        // Validate if passwords match
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new RuntimeException("Passwords do not match");
        }

        // Check if user already exists
        if (userRepository.findByEmail(request.getEmail()).isPresent()) {
            throw new RuntimeException("User already exists with email: " + request.getEmail());
        }

        // Create new user
        User user = new User();
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setRole("USER"); // Default role

        // Save user
        user = userRepository.save(user);
        logger.debug("User registered successfully: {}", user.getEmail());

        // Generate token
        String token = jwtUtil.generateToken(user.getEmail());

        // Return auth response
        return new AuthResponse(
            user.getId(),
            user.getName(),
            user.getEmail(),
            user.getRole(),
            token
        );
    }
} 