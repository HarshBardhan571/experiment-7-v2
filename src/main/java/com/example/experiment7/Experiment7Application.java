package com.example.experiment7;

import com.example.experiment7.entity.User;
import com.example.experiment7.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class Experiment7Application {

    public static void main(String[] args) {
        SpringApplication.run(Experiment7Application.class, args);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public CommandLineRunner dataLoader(UserRepository userRepository, PasswordEncoder encoder) {
        return args -> {
            if (userRepository.findByUsername("user1").isEmpty()) {
                User u = new User();
                u.setUsername("user1");
                u.setPassword(encoder.encode("user123"));
                u.setRole("USER");
                userRepository.save(u);
            }

            if (userRepository.findByUsername("admin1").isEmpty()) {
                User a = new User();
                a.setUsername("admin1");
                a.setPassword(encoder.encode("admin123"));
                a.setRole("ADMIN");
                userRepository.save(a);
            }
        };
    }
}
