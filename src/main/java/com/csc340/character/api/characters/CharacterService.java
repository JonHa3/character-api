package com.csc340.character.api.characters;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CharacterService {

    private final CharacterRepository repository;

    public CharacterService(CharacterRepository repository) {
        this.repository = repository;
    }

    // Combines the optional filters. Either argument may be null or blank.
    public List<CartoonCharacter> search(String name, String network) {
        boolean hasName = name != null && !name.isBlank();
        boolean hasNetwork = network != null && !network.isBlank();

        if (hasName && hasNetwork) {
            return repository.findByNameContainingIgnoreCaseAndNetworkIgnoreCase(name.trim(), network.trim());
        }
        if (hasName) {
            return repository.findByNameContainingIgnoreCase(name.trim());
        }
        if (hasNetwork) {
            return repository.findByNetworkIgnoreCase(network.trim());
        }
        return repository.findAll();
    }

    public CartoonCharacter findById(Long id) {
        return repository.findById(id).orElseThrow(() -> new CharacterNotFoundException(id));
    }

    public CartoonCharacter create(CartoonCharacter character) {
        return repository.save(character);
    }

    public CartoonCharacter update(Long id, CartoonCharacter updated) {
        CartoonCharacter existing = findById(id); // throws 404 if missing
        existing.setName(updated.getName());
        existing.setDescription(updated.getDescription());
        existing.setNetwork(updated.getNetwork());
        existing.setSpecies(updated.getSpecies());
        existing.setFirstAppearance(updated.getFirstAppearance());
        return repository.save(existing);
    }

    public void delete(Long id) {
        findById(id); // throws 404 if missing
        repository.deleteById(id);
    }
}
