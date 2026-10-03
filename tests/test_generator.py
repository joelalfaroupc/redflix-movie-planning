import unittest, tempfile, random
from pathlib import Path
from generate import generate_pddl_problem

class GeneratorTests(unittest.TestCase):
    def test_small_extension_two(self):
        with tempfile.TemporaryDirectory() as d:
            for n in [1,2]:
                f=Path(d)/'problem.pddl'
                generate_pddl_problem(n,'2',str(f))
                self.assertIn('(:goal',f.read_text())

    def test_seed_reproducibility_without_global_random_mutation(self):
        with tempfile.TemporaryDirectory() as d:
            a,b=Path(d)/'a',Path(d)/'b'
            before=random.getstate()
            generate_pddl_problem(12,'4',str(a),seed=42)
            generate_pddl_problem(12,'4',str(b),seed=42)
            self.assertEqual(a.read_bytes(),b.read_bytes())
            self.assertEqual(before,random.getstate())

    def test_invalid_arguments(self):
        with tempfile.TemporaryDirectory() as d:
            for n,e in [(0,'4'),(3,'5')]:
                with self.assertRaises(ValueError): generate_pddl_problem(n,e,str(Path(d)/'p'))

if __name__=='__main__': unittest.main()
