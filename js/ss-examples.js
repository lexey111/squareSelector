/**
 * Created by lexey on 11/6/13.
 */

var example_selector_1; // button to show state switching
var example_selector_2; // button to show item state switching
var example_selector_3; // button to rebuild list

// onDocumentReady
$(function () {
    var item_container = $('#selectors_container1');
    new LxSquareSelector({
        container: item_container,
        title: 'Size',
        subtitle: 'of paper',
        active: '90x90',
        list: [
            {
                value: '50x50',
                display: '5x5cm',
                line: '5x5 cm (tiny glass)'
            },
            {
                value: '70x70',
                display: '7x7cm',
                line: '7x7 cm (coffee or tea cup)'
            },
            {
                value: '90x90',
                display: '9x9cm',
                line: '9x9 cm (standard)'
            },
            {
                value: '90x50',
                display: '9x5cm',
                line: '9x5 cm (business card)'
            }
        ],
        callback: function (value) {
            alert('Selected paper: ' + value);
        }
    });

    new LxSquareSelector({
        container: item_container,
        title: 'Margins',
        subtitle: 'size',
        active: '10',
        list_align: 'right',
        list_width: 100,
        list: [
            {
                value: '0',
                display: 'None',
                line: 'No margins',
                separated: true
            },
            {
                value: '1',
                display: '1mm',
                line: '1mm'
            },
            {
                value: '3',
                display: '3mm',
                line: '3mm'
            },
            {
                value: '5',
                display: '5mm',
                line: '5mm'
            },
            {
                value: '7',
                display: '7mm',
                line: '7mm'
            },
            {
                value: '10',
                display: '10mm',
                line: '10mm'
            },
            {
                value: '15',
                display: '15mm',
                line: '15mm'
            },
            {
                value: '20',
                display: '20mm',
                line: '20mm'
            }
        ],
        callback: function (value) {
            alert('Selected margin: ' + value);
        }

    });

    new LxSquareSelector({
        container: item_container,
        title: 'Background',
        active: 'clean',
        list_header: "Choose background from this list",
        list_footer: "This is only example of color or texture. It won't be printed.",
        list_align: 'left',
        list: [
            {
                value: 'clean',
                display: 'Clean',
                line: 'Clean paper',
                separated: true
            },
            {
                value: 'color',
                display: 'Color',
                line: 'Solid color...',
                separated: true
            },
            {
                value: 'texture1.jpg',
                display: 'Gray',
                line: 'Gray cardboard'
            },
            {
                value: 'texture2.jpg',
                disabled: true,
                display: 'Green',
                line: 'Green cardboard'
            },
            {
                value: 'texture3.jpg',
                disabled: true,
                display: 'Fibers',
                line: 'Paper with fibers'
            },
            {
                value: 'texture4.jpg',
                display: 'Textured',
                line: 'Textured paper'
            },
            {
                value: 'deep_sea.jpg',
                display: 'Sea',
                line: 'Blue deep sea'
            },
            {
                value: 'earth.jpg',
                display: 'Earth',
                line: 'Brown earth paper'
            }
        ],
        callback: function (value) {
            alert('Selected texture: ' + value);
        }
    });

    new LxSquareSelector({
        container: item_container,
        title: 'Red button',
        subtitle: 'no list<br>red-button giant-button right-float',
        class_name: 'red-button giant-button right-float',
        active: 'Print',
        list: [
            {
                value: 'Print',
                display: 'CLICK HERE TO PRINT'
            }
        ],
        callback: function () {
            alert('Print button clicked');
        }
    });

    new LxSquareSelector({
        container: item_container,
        title: 'Red button',
        subtitle: 'With list',
        class_name: 'red-button',
        active: 'beer',
        list: [
            {
                value: 'beer',
                display: 'Beer'
            },
            {
                value: 'vodka',
                display: 'Vodka'
            },
            {
                value: 'cognac',
                display: 'Cognac'
            },
            {
                value: 'brendy',
                display: 'Brendy'
            }
        ],
        callback: function (value) {
            alert('Alcohol button clicked: ' + value);
        }
    });

    new LxSquareSelector({
        container: item_container,
        title: 'Green button',
        subtitle: 'No list',
        class_name: 'green-button',
        active: 'Preview',
        list: [
            {
                value: 'Preview',
                display: 'PREVIEW'
            }
        ],
        callback: function () {
            alert('Preview button clicked');
        }
    });

    new LxSquareSelector({
        container: item_container,
        title: 'Blue button',
        subtitle: 'No list',
        class_name: 'blue-button',
        active: 'Send',
        list: [
            {
                value: 'Send',
                display: 'SEND'
            }
        ],
        callback: function () {
            alert('Send button clicked');
        }
    });

    // Special selectors
    example_selector_1 = new LxSquareSelector({
        container: '#scs1 span',
        title: 'Size',
        disabled: true,
        subtitle: 'of paper',
        active: '90x90',
        list: [
            {
                value: '50x50',
                display: '5x5cm',
                line: '5x5 cm (tiny glass)'
            },
            {
                value: '70x70',
                display: '7x7cm',
                line: '7x7 cm (coffee or tea cup)'
            },
            {
                value: '90x90',
                display: '9x9cm',
                line: '9x9 cm (standard)'
            },
            {
                value: '90x50',
                display: '9x5cm',
                line: '9x5 cm (business card)'
            }
        ],
        callback: function (value) {
            alert('Selected paper: ' + value);
        }
    });

    example_selector_2 = new LxSquareSelector({
        container: '#scs2 span',
        title: 'Fruit',
        subtitle: 'list',
        active: 'banana',
        class_name: 'round-button',
        list: [
            {
                value: 'banana',
                display: 'Banana'
            },
            {
                value: 'orange',
                display: 'Orange'
            },
            {
                value: 'peach',
                display: 'Peach'
            },
            {
                value: 'apple',
                display: 'Apple'
            }
        ],
        callback: function (value) {
            alert('Selected fruit: ' + value);
        }
    });
    new LxSquareSelector({
        container: '#scs3 span',
        title: 'Gender',
        active: 'male',
        class_name: 'round-button-animated',
        list_width: 100,
        list: [
            {
                value: 'male',
                display: 'Male'
            },
            {
                value: 'female',
                display: 'Female'
            }
        ],
        callback: function (value) {
            alert('Selected gender: ' + value);
        }
    });
    example_selector_3 = new LxSquareSelector({
        container: '#scs4 span',
        title: 'Pet',
        active: 'dog',
        class_name: 'rounded-button',
        list_width: 100,
        list: [
            {
                value: 'dog',
                display: 'Dog'
            },
            {
                value: 'cat',
                display: 'Cat'
            },
            {
                value: 'turtle',
                display: 'Turtle'
            }
        ],
        callback: function (value) {
            alert('Selected pet: ' + value);
        }
    });

    $('#disable_enable_link').unbind().click(function(e){
        e.preventDefault();

        if (example_selector_1.disabled()){
            alert('Disabled -> enable');
            example_selector_1.enable();
        } else {
            alert('Enabled -> disable');
            example_selector_1.disable();
        }

        return false;
    });

    $('#disable_orange_link').unbind().click(function(e){
        e.preventDefault();

        if (example_selector_2.itemDisabled('orange')){
            alert('Disabled -> enable');
            example_selector_2.enableItem('orange');
        } else {
            alert('Enabled -> disable');
            example_selector_2.disableItem('orange');
        }

        return false;
    });

    $('#rebuild_link').unbind().click(function(e){
        e.preventDefault();
        var new_list = [
            {
                value: 'owl',
                display: 'Owl',
                line: 'Polar owl'
            },
            {
                value: 'sparrow',
                display: 'Sparrow',
                line: 'Jack the Sparrow'
            },
            {
                value: 'goose',
                display: 'Goose',
                line: 'Gray goose'
            },
            {
                value: 'martlet',
                display: 'Martlet',
                line: 'Fast martlet'
            }
        ];
        example_selector_3.rebuild(new_list, 'sparrow');
        return false;
    });

});