package com.csc340.character.api.characters;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Serves the HTML pages. Separate from CharacterController, which serves JSON at /api/characters.
 * Talks to the service layer directly, never to the REST API over HTTP.
 */
@Controller
public class CharacterPageController {

    private final CharacterService service;

    public CharacterPageController(CharacterService service) {
        this.service = service;
    }

    // Gallery, with optional search: /?name=gum&network=Cartoon%20Network
    @GetMapping("/")
    public String gallery(@RequestParam(required = false) String name,
                          @RequestParam(required = false) String network,
                          Model model) {
        model.addAttribute("characters", service.search(name, network));
        model.addAttribute("networks", service.findAllNetworks());
        // Send the typed values back so the inputs stay filled in after searching
        model.addAttribute("name", name);
        model.addAttribute("network", network);
        return "index";
    }

    // Details for one character
    @GetMapping("/characters/{id}")
    public String details(@PathVariable Long id, Model model) {
        model.addAttribute("character", service.findById(id));
        return "details";
    }
}
