package com.csc340.character.api.characters;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CharacterRepository extends JpaRepository<CartoonCharacter, Long> {

    // GET /api/characters?name=abc  -> partial, case-insensitive match
    List<CartoonCharacter> findByNameContainingIgnoreCase(String name);

    // GET /api/characters?network=Nickelodeon  -> exact match, ignoring case
    List<CartoonCharacter> findByNetworkIgnoreCase(String network);

    // GET /api/characters?name=a&network=Disney  -> both filters together
    List<CartoonCharacter> findByNameContainingIgnoreCaseAndNetworkIgnoreCase(String name, String network);
}
