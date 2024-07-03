package com.example.credential_service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/users")
public class CredentialController {

    @Autowired
    private CredentialService credentialService;

    @GetMapping("/{role}")
    public ResponseEntity<UserEntity> getCredentialsByRole(@PathVariable String role) {
        Optional<UserEntity> user = credentialService.getUserByRole(role);
        if (user.isPresent()) {
            return ResponseEntity.ok(user.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping
    public List<UserEntity> getAllUsers() {
        return credentialService.getAllUsers();
    }
}