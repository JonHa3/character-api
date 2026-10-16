package com.csc340.character.api.characters;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/characters")
public class CharacterController {

    private final CharacterService service;

    public CharacterController(CharacterService service) {
        this.service = service;
    }

    // GET /api/characters, /api/characters?name=abc, /api/characters?network=Disney
    @GetMapping
    public List<CartoonCharacter> list(@RequestParam(required = false) String name,
                                       @RequestParam(required = false) String network) {
        return service.search(name, network);
    }

    @GetMapping("/{id}")
    public CartoonCharacter get(@PathVariable Long id) {
        return service.findById(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public CartoonCharacter create(@Valid @RequestBody CartoonCharacter character) {
        return service.create(character);
    }

    @PutMapping("/{id}")
    public CartoonCharacter update(@PathVariable Long id,
                                   @Valid @RequestBody CartoonCharacter character) {
        return service.update(id, character);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
