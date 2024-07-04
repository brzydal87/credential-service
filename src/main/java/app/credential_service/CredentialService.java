package app.credential_service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CredentialService {

    @Autowired
    private UserRepository userRepository;

    public Optional<UserEntity> getUserByRole(String role) {
        return userRepository.findByRole(role);
    }

    public List<UserEntity> getAllUsers() {
        return userRepository.findAll();
    }
}
